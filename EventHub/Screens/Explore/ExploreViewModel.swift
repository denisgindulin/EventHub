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
    
    let currentPosition: String = "New York, USA"
    
    @Published var searchString: String = ""
    
    @Published var upcomingEvents: [Event] = []
    @Published var nearbyYouEvents: [Event] = []
    @Published var categories: [CategoryUIModel] = []
    @Published var locations: [EventLocation] = []
    
    @Published var error: Error? = nil
    @Published var currentCategory: String? = nil
    @Published var currentLocation: String = "msk"
    
    var isFavoriteEvent = false

    private let apiService: IEventAPIServiceForExplore
    
    private let language = Language.en
    
    private var page: Int = 1
    
    // MARK: - INIT
    init(actions: ExploreActions, apiService: IEventAPIServiceForExplore) {
        self.actions = actions
        self.apiService = apiService
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
            
//            let apiSpec = EventAPISpec.getUpcomingEventsWith(
//                category: currentCategory,
//                language: language,
//                page: page
//            )
//            print("Endpoint Events: \(apiSpec.endpoint)")
            
            upcomingEvents = eventsDTO.map { dto in
                Event(
                    id: dto.id,
                    title: dto.title ?? "No Title",
                    visitors: dto.participants?.map { participant in
                        Visitor(
                            image: participant.agent?.images?.first ?? "default_visitor_image",
                            name: participant.agent?.title ?? "No participant"
                        )
                    },
                    date: dto.dates.first?.startDate ?? (Date(timeIntervalSince1970: TimeInterval((dto.dates.first?.start ?? 1489312800))).formattedDate(format: "dd\nMMM")),
                    adress: dto.place?.address ?? "Unknown Address",
                    image: dto.images.first?.image,
                    isFavorite: isFavoriteEvent
                )
            }
        } catch {
            self.error = error
        }
    }
    
    func featchNearbyYouEvents() async {
        do {
            let eventsDTO = try await apiService.getNearbyYouEvents(with: language, currentLocation, page)
            
//            let apiSpec = EventAPISpec.getUpcomingEventsWith(
//                category: currentCategory,
//                language: language,
//                page: page
//            )
//            print("Endpoint Events: \(apiSpec.endpoint)")
            
            nearbyYouEvents = eventsDTO.map { dto in
                Event(
                    id: dto.id,
                    title: dto.title ?? "No Title",
                    visitors: dto.participants?.map { participant in
                        Visitor(
                            image: participant.agent?.images?.first ?? "default_visitor_image",
                            name: participant.agent?.title ?? "No participant"
                        )
                    },
                    date: dto.dates.first?.startDate ?? (Date(timeIntervalSince1970: TimeInterval((dto.dates.first?.start ?? 1489312800))).formattedDate(format: "dd\nMMM")),
                    adress: dto.place?.address ?? "Unknown Address",
                    image: dto.images.first?.image,
                    isFavorite: isFavoriteEvent
                )
            }
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
