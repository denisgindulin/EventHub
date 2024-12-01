//
//  MapViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import MapKit

@MainActor
final class MapViewModel: ObservableObject {
    
    private let apiService: IAPIServiceForMap
    let locationManager: LocationManager
    
    @Published var categories: [CategoryUIModel] = []
    @Published var events: [MapEventModel] = []
    @Published var currentCategory: String? = nil {
        didSet {
            Task {
                await fetchEvents()
            }
        }
    }
    @Published var region: MKCoordinateRegion
    @Published var error: Error? = nil
    
    private let language = Language.ru
    private var page: Int = 1
    
    // MARK: - Init
    init(apiService: IAPIServiceForMap = DIContainer.resolve(forKey: .networkService) ?? EventAPIService(),
         locationManager: LocationManager = LocationManager()) {
        self.apiService = apiService
        self.locationManager = locationManager

        if let userLocation = locationManager.location {
            self.region = MKCoordinateRegion(
                center: userLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        } else {
            self.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6176),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }

        locationManager.locationDidUpdate = { [weak self] newLocation in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.region = MKCoordinateRegion(
                    center: newLocation,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            }
        }
    }
    
    // MARK: - Fetch Events
    func fetchEvents() async {
        do {
            let eventsDTO = try await apiService.getEventsWith(
                location: "",
                currentCategory,
                language
            )
            events = eventsDTO.map { MapEventModel(dto: $0) }
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

