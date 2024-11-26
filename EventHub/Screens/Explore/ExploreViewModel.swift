//
//  ExploreViewViewModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI
import Combine

struct ExploreActions {
    let showDetail: (Int) -> Void
    let closed: CompletionBlock
}

final class ExploreViewModel: ObservableObject {
    
    let actions: ExploreActions
    
    let functionalButtonsNames = ["Today","Films", "Lists"]
    @Published var choosedButton: String = "" // кнопка поl категориями, незнаю как назвать это
    @Published var currentPosition: String = "Moscow"
    @Published var searchText: String = ""
    
    @Published var upcomingEvents: [Event] = []
    @Published var nearbyYouEvents: [Event] = []
    @Published var categories: [CategoryUIModel] = []
    @Published var locations: [EventLocation] = []
    
    @Published var error: Error? = nil
    @Published var currentCategory: String? = nil
    @Published var currentLocation: String = "msk" {
        didSet {
            
            Task {
                await featchNearbyYouEvents()
            }}
    }
    
    var isFavoriteEvent = false

    private let apiService: IEventAPIServiceForExplore
    
    private let language = Language.en
    
    private var page: Int = 1
    
    // MARK: - INIT
    init(actions: ExploreActions, apiService: IEventAPIServiceForExplore) {
        self.actions = actions
        self.apiService = apiService
    }
    
    // MARK: - Filter Events
    func filterEvents(orderType: DisplayOrderType) {
        switch orderType {
        case .alphabetical:
            upcomingEvents = upcomingEvents.sorted(by: { $0.title < $1.title })
        case .date:
            upcomingEvents = upcomingEvents.sorted(by: { $0.date < $1.date })
        }
    }
    
    // MARK: - Network API Methods
    func fetchLocations() async {
        do {
            let fetchedLocations = try await apiService.getLocations(with: language)
            await MainActor.run { [weak self] in
                self?.locations = fetchedLocations
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
    
    func fetchCategories() async {
        do {
            let categoriesFromAPI = try await apiService.getCategories(with: language) ?? []
            await loadCategories(from: categoriesFromAPI)
        } catch {
            self.error = error
        }
    }
    
    func fetchUpcomingEvents() async {
        do {
            let eventsDTO = try await apiService.getUpcomingEvents(
                with: currentCategory,
                language,
                page
            )
            
            upcomingEvents = eventsDTO.map { Event(dto: $0, isFavorite: isFavoriteEvent) }
        } catch {
            self.error = error
        }
    }
    
    func featchNearbyYouEvents() async {
        do {
            let eventsDTO = try await apiService.getNearbyYouEvents(
                with: language,
                currentLocation,
                page
            )
            nearbyYouEvents = eventsDTO.map { Event(dto: $0, isFavorite: isFavoriteEvent) }
        } catch {
            self.error = error
        }
    }
    
//    MARK: -  Navigation
    func showDetail(_ eventID: Int) {
        print("showDetails: \(eventID)")
        actions.showDetail(eventID)
    }
    
    func close() {
        actions.closed()
    }
    
    
    //    MARK: - Helper Methods
    private func loadCategories(from eventCategories: [CategoryDTO]) async {
        let mappedCategories = eventCategories.map { category in
            let color = CategoryImageMapping.color(for: category)
            let image = CategoryImageMapping.image(for: category)
            return CategoryUIModel(id: category.id, category: category, color: color, image: image)
        }
        
        await MainActor.run { [weak self] in
            self?.categories = mappedCategories
        }
    }
    

    
}
