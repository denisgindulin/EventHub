//
//  EventModel.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 30.11.2024.
//

import MapKit
import CoreLocation
struct MapEventModel: Identifiable {
    var id: Int
    let title: String
    let coords: CLLocationCoordinate2D
    let image: String
}

extension MapEventModel {
    init(dto: EventDTO) {
        self.id = dto.id
        self.title = dto.title ?? ""
        self.coords = dto.place?.coords.toCLLocationCoordinate2D ?? CLLocationCoordinate2D()
        self.image = dto.images.first?.image ?? "cardImg1"
    }
}
