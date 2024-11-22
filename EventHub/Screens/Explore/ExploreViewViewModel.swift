//
//  ExploreViewViewModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

@MainActor
final class ExploreViewViewModel: ObservableObject {
    let currentPosition: String = "New York, USA"
    let categoryColors: [Color] = [.appRed, .appOrange, .appGreen, .appCyan]
    let categoryPictures: [String] = ["ball", "music","eat", "profile"] // paint image = person ???
    
    
    @Published var events: [EventDTO] = []
    @Published var categories: [CategoryUIModel] = []
    @Published var locations: [EventLocation] = []
    @Published var error: Error? = nil
    
    private let apiService: IEventAPIService
    
    private var currentCategory: String = ""
    private var currentLocation: String = ""
    private let language = Language.en
    private var page: Int = .zero
    
    // MARK: - INIT
    init(apiService: IEventAPIService) {
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
            events = try await apiService.getEvents(with: currentLocation, language, currentCategory, page: String(page))
        } catch {
            self.error = error
        }
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
