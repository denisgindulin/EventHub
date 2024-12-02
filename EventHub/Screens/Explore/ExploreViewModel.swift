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
    
    let functionalButtonsNames = ["Today".localized, "Films".localized, "Lists".localized]
    @Published var choosedButton: String = "" // кнопка поl категориями, незнаю как назвать это
    @Published var currentPosition: String = "Moscow".localized
    
    @Published var todayEvents: [ExploreModel] = []
    @Published var films: [ExploreModel] = []
    @Published var lists: [ExploreModel] = []
    
    @Published var upcomingEvents: [ExploreModel] = []
    @Published var nearbyYouEvents: [ExploreModel] = []
    @Published var categories: [CategoryUIModel] = []
    @Published var locations: [EventLocation] = []
    
    @Published var emptyUpcoming = false
    @Published var emptyNearbyYou = false
    
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
    
    private let language = Language.ru
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
            nearbyYouEvents = nearbyYouEvents.sorted(by: { $0.title < $1.title })
        case .date:
            upcomingEvents = upcomingEvents.sorted(by: { $0.date < $1.date })
            nearbyYouEvents = nearbyYouEvents.sorted(by: { $0.date < $1.date })
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
        emptyUpcoming = false
        do {
            let fetchedEvents = try await apiService.getUpcomingEvents(
                with: currentCategory,
                language,
                page
            )
            let _ = EventAPISpec.getUpcomingEventsWith(
                category: currentCategory,
                language: language,
                page: page
            )
            let mappedEvents = fetchedEvents.map { ExploreModel(dto: $0) }
            
            let filteredEvents = ExploreModel.filterExploreEvents(mappedEvents)
            
            self.upcomingEvents = filteredEvents
            
            if upcomingEvents.isEmpty {
                emptyUpcoming = true
            }

        } catch {
            self.error = error
        }
    }
    
    func featchNearbyYouEvents() async {
        emptyNearbyYou = false
        do {
            let eventsDTO = try await apiService.getNearbyYouEvents(
                with: language,
                currentLocation,
                currentCategory,
                page
            )
            let mappedEvents = eventsDTO.map { ExploreModel(dto: $0) }
            let filteredEvents = ExploreModel.filterExploreEvents(mappedEvents)
            nearbyYouEvents = filteredEvents
            
            if nearbyYouEvents.isEmpty {
                emptyNearbyYou = true
            }
            
        } catch {
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


extension ExploreViewModel {
    
    
    func getToDayEvents() async {
        do {
            let fetchedTodayEvents = try await apiService.getToDayEvents(location: currentLocation, language: language, page: page)
            
            let objectIDs = fetchedTodayEvents.compactMap { $0.object.id }
            let idString = objectIDs.map(String.init).joined(separator: ",")
            
            let detailsEvents = try await apiService.getEventDetails(eventIDs: idString, language: language)
            self.todayEvents = detailsEvents.map { ExploreModel(dto: $0) }

        } catch {
            self.error = error
        }
    }
    
    func getFilms() async {
        do {
            let fetchedFilms = try await apiService.getMovies(location: currentLocation, language: language, page: page)
            
            self.films = fetchedFilms.map { ExploreModel(movieDto: $0 )}
        } catch {
            self.error = error
        }
    }
    
    
    func getLists() async {
        do {
            let fetchedList = try await apiService.getLists(location: currentLocation, language: language, page: page)
            
            let apiSpecLoc = EventAPISpec.getLists(location: currentLocation, language: language, page: page)
            print("getFilms: \(apiSpecLoc.endpoint)")
            
            self.lists = fetchedList.map { ExploreModel(listDto: $0 )}
        } catch {
            self.error = error
        }
    }
    
}
