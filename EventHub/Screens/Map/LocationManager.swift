//
//  LocationManager.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 30.11.2024.
//


import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    var locationDidUpdate: ((CLLocationCoordinate2D) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            location = newLocation.coordinate
            locationDidUpdate?(newLocation.coordinate)
        }
    }
}
