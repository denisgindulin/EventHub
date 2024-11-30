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
    private let locationManager: LocationManager

    @Published var events: [MapEventModel] = []
    @Published var selectedCategory: String? = nil
    @Published var region: MKCoordinateRegion
    @Published var isFavorite: Bool = false
    @Published var error: Error? = nil
    
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
                center: CLLocationCoordinate2D(latitude: 56.8389, longitude: 60.6057),
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
            let eventsDTO = try await apiService.getAllEvents(
                selectedCategory,
                getActualSince(),
                Language.ru,
                page
            )
            events = eventsDTO.map { MapEventModel(dto: $0) }
        } catch {
            self.error = error
        }
    }
    
    private func getActualSince() -> String {
        let currentDate = Date()
        return String(Int(currentDate.timeIntervalSince1970))
    }
}

