//
//  ExploreViewViewModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

@MainActor
final class ExploreViewModel: ObservableObject {
    
    private let apiService: IAPIServiceForExplore
    
    let functionalButtonsNames = ["Today".localized,"Films".localized, "Lists".localized]
    @Published var choosedButton: String = "" // кнопка поl категориями, незнаю как назвать это
    @Published var currentPosition: String = "Moscow".localized
    @Published var searchText: String = "" {
        didSet {
            Task {
                await fetchSearchedEvents()
            }
        }
    }
    
    @Published var searchedEvents: [EventDTO] = []
    
    @Published var upcomingEvents: [ExploreEvent] = []
    @Published var nearbyYouEvents: [ExploreEvent] = []
    @Published var categories: [CategoryUIModel] = []
    @Published var locations: [EventLocation] = []
    
    @Published var error: Error? = nil
    
    @Published var currentLocation: String = "msk" {
        didSet{
            Task {
                await featchNearbyYouEvents()
            }
        }
    }
    
        @Published var currentCategory: String? = nil {
            didSet{
                Task {
                    await fetchUpcomingEvents()
                    await featchNearbyYouEvents()
                }
            }
        }
        
    var isFavoriteEvent = false
    
    
    private let language = Language.en
    
    private var page: Int = 1
    
    // MARK: - INIT
    init(apiService: IAPIServiceForExplore = DIContainer.resolve(forKey: .networkService) ?? EventAPIService()) {
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
            self.locations = fetchedLocations
            
        } catch {
            self.error = error
        }
    }
    
    func fetchCategories() async {
        do {
            let categoriesFromAPI = try await apiService.getCategories(with: language)
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
            
            upcomingEvents = eventsDTO.map { ExploreEvent(dto: $0) }
        } catch {
            self.error = error
        }
    }
    
    func featchNearbyYouEvents() async {
        do {
            let eventsDTO = try await apiService.getNearbyYouEvents(
                with: language,
                currentLocation,
                currentCategory,
                page
            )
            nearbyYouEvents = eventsDTO.map { ExploreEvent(dto: $0) }
        } catch {
            self.error = error
        }
    }
    
    func fetchSearchedEvents() async {
        do {
            let eventsDTO = try await apiService.getSearchedEvents(with: searchText)
            searchedEvents = eventsDTO?.results ?? [ ]
            print(Int(eventsDTO?.results.count ?? 1232))
        } catch {
            print(" No searched func result")
            self.error = error
        }
    }
    
    
    //    MARK: - Helper Methods
    private func loadCategories(from eventCategories: [CategoryDTO]) async {
        let mappedCategories = eventCategories.map { category in
            let color = CategoryImageMapping.color(for: category)
            let image = CategoryImageMapping.image(for: category)
            return CategoryUIModel(id: category.id, category: category, color: color, image: image)
        }
        self.categories = mappedCategories
    }
}
