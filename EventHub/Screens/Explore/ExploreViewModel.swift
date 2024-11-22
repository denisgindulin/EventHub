//
//  ExploreViewViewModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI
import Combine

struct ExploreActions {
    let showDetail: CompletionBlock
    let closed: CompletionBlock
}

final class ExploreViewModel: ObservableObject {
    
    let actions: ExploreActions
    
    let currentPosition: String = "New York, USA"
    let categoryColors: [Color] = [.appRed, .appOrange, .appGreen, .appCyan]
    let categoryPictures: [String] = ["ball", "music","eat", "profile"] // paint image = person ???
    
    
    @Published var events: [Event] = []
    @Published var categories: [CategoryUIModel] = []
    @Published var locations: [EventLocation] = []
    @Published var error: Error? = nil
    @Published var currentCategory: String = "cinema"
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
            locations = try await apiService.getLocations(with: language)
        } catch {
            self.error = error
        }
    }
    
    func fetchCategories() async {
        do {
            let categoriesFromAPI = try await apiService.getCategories(with: language) ?? []
            loadCategories(from: categoriesFromAPI)
        } catch {
            self.error = error
        }
    }
    
    func fetchEvents() async {
        do {
            let eventsDTO = try await apiService.getEvents(
                with: currentCategory,
                currentLocation,
                language,
                page
            )
            let apiSpec = EventAPISpec.getEventsWith(
                category: currentCategory,
                location: currentLocation,
                language: language,
                page: page
            )
            print("Endpoint Events: \(apiSpec.endpoint)")
            
            events = eventsDTO.map { dto in
                Event(
                    id: dto.id,
                    title: dto.title ?? "No Title",
                    visitors: dto.participants?.map { participant in
                        Visitor(
                            image: participant.agent.images.first ?? "default_visitor_image",
                            name: participant.agent.title
                        )
                    },
                    date: dto.dates.first?.startDate ?? "Unknown Date",
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
    func showDetail() {
        actions.showDetail()
    }
    
    func close() {
        actions.closed()
    }
    
    
    //    MARK: - Helper Methods
    private func loadCategories(from eventCategories: [CategoryDTO]) {
        categories = eventCategories.map { category in
            let color = CategoryImageMapping.color(for: category)
            let image = CategoryImageMapping.image(for: category)
            return CategoryUIModel(id: category.id, category: category, color: color, image: image)
        }
    }
}
