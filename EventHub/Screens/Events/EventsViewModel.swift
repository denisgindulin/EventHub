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

final class EventsViewModel: ObservableObject {
    // MARK: - Properties
    let actions: EventsActions
    private let apiService: IEventAPIServiceForEvents
    private let language = Language.en
    
    private var page: Int = 1
    @Published var allEvents: [EventModel] = []
    @Published var upcomingEvents: [EventModel] = []
    @Published var pastEvents: [EventModel] = []
    
    @Published var error: Error? = nil
    
    @Published var selectedMode: EventsMode = .upcoming
    
    // MARK: - Initialization
    init(apiService: IEventAPIServiceForEvents, actions: EventsActions) {
        self.apiService = apiService
        self.actions = actions
    }
    
    // MARK: - Fetch Events
    func fetchUpcomingEvents() async {
        do {
            let eventsDTO = try await apiService.getUpcomingEvents(
                getActualSince(),
                getActualUntil(),
                language,
                page
            )
            await MainActor.run { [weak self] in
                self?.upcomingEvents = eventsDTO.map { EventModel(dto: $0) }
            }
        } catch {
            self.error = error
            print("Failed to fetch upcoming events: \(error)")
        }
    }
    
    func fetchPastEvents() async {
        do {
            let eventsDTO = try await apiService.getPastEventsEvents(
                getActualSince(),
                language,
                page
            )
            await MainActor.run { [weak self] in
                self?.pastEvents = eventsDTO.map { EventModel(dto: $0) }
            }
        } catch {
            self.error = error
        }
    }
    
    // MARK: - Events Filtering
    func eventsForCurrentMode() -> [EventModel] {
        switch selectedMode {
        case .upcoming:
            return upcomingEvents
        case .pastEvents:
            return pastEvents
        }
    }
    
    // MARK: - Date Calculation
    private func getActualSince() -> String {
        let currentDate = Date()
        let actualSince = Int(currentDate.timeIntervalSince1970)
        return String(actualSince)
    }

    
    private func getActualUntil() -> String {
        let currentDate = Date()
        let calendar = Calendar(identifier: .gregorian)
        guard let untilDate = calendar.date(byAdding: .day, value: 7, to: currentDate)
        else {
            return ""
        }
        return untilDate.iso8601Format()
    }
}
