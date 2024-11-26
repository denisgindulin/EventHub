//
//  EventsViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct EventsActions {
    let closed: CompletionBlock
}

// MARK: - FetchTaskToken

struct FetchTaskToken: Equatable {
    var events: String
    var token: Date
}

// MARK: - EventsViewModel
final class EventsViewModel: ObservableObject {
    // MARK: - Properties
    
    let actions: EventsActions
    
    private let apiService: IEventAPIServiceForEvents
    private let cache: DiskCache<[EventDTO]>
    private let language: Language = .en
    private let timeIntervalForUpdateCache: TimeInterval = 24 * 60
    
    @Published var selectedMode: EventsMode = .upcoming
    @Published var upcomingEventsPhase: DataFetchPhase<[EventModel]> = .empty
    @Published var pastEventsPhase: DataFetchPhase<[EventModel]> = .empty
    @Published var fetchTaskToken: FetchTaskToken
    
    private var page: Int = 1
    
    // MARK: - Initialization
    init(actions: EventsActions, apiService: IEventAPIServiceForEvents) {
        self.actions = actions
        self.apiService = apiService
        self.cache = DiskCache<[EventDTO]>(
            filename: "xca_events",
            expirationInterval: timeIntervalForUpdateCache
        )
        self.fetchTaskToken = FetchTaskToken(events: "Events", token: Date())
        
        Task(priority: .high) {
            try? await cache.loadFromDisk()
        }
    }
    
    // MARK: - Fetch Events
    func fetchUpcomingEvents(ignoreCache: Bool = false) async {
        await updatePhase(
            &upcomingEventsPhase,
            cacheKey: fetchTaskToken.events,
            ignoreCache: ignoreCache
        ) {
            try await self.apiService.getUpcomingEvents(
                self.getActualSince(),
                self.getActualUntil(),
                self.language,
                self.page
            )
        }
    }
    
    func fetchPastEvents() async {
        await updatePhase(&pastEventsPhase, cacheKey: nil, ignoreCache: true) {
            try await self.apiService.getPastEventsEvents(
                self.getActualSince(),
                self.language,
                self.page
            )
        }
    }
    
    private func updatePhase(
        _ phase: inout DataFetchPhase<[EventModel]>,
        cacheKey: String?,
        ignoreCache: Bool,
        fetch: @escaping () async throws -> [EventDTO]
    ) async {
        do {
            if let cacheKey = cacheKey, !ignoreCache, let cachedEvents = await cache.value(forKey: cacheKey) {
                phase = .success(cachedEvents.map { EventModel(dto: $0) })
            } else {
                let eventsDTO = try await fetch()
                if let cacheKey = cacheKey {
                    await cache.setValue(eventsDTO, forKey: cacheKey)
                    try? await cache.saveToDisk()
                }
                phase = .success(eventsDTO.map { EventModel(dto: $0) })
            }
        } catch {
            phase = .failure(error)
        }
    }
    
    func refreshTask() async {
        await cache.removeValue(forKey: fetchTaskToken.events)
        fetchTaskToken.token = Date()
    }
    
    // MARK: - Helpers
    func eventsForCurrentMode() -> [EventModel] {
        switch selectedMode {
        case .upcoming:
            return upcomingEventsPhase.value ?? []
        case .pastEvents:
            return pastEventsPhase.value ?? []
        }
    }
    
    private func getActualSince() -> String {
        let currentDate = Date()
        return String(Int(currentDate.timeIntervalSince1970))
    }

    private func getActualUntil() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let untilDate = calendar.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        return untilDate.iso8601Format()
    }
}

extension EventsViewModel {
    func errorMessage(for phase: DataFetchPhase<[EventModel]>) -> String {
        if case .failure(let error) = phase {
            return error.localizedDescription
        }
        return "Unknown error"
    }
}
