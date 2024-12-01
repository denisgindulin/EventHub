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
//    let typeImage: String
    let title: String
    let date: Date
    let place: String
    let coords: CLLocationCoordinate2D
    let image: String
}

extension MapEventModel {
    init(dto: EventDTO) {
        self.id = dto.id
        self.title = dto.title ?? ""
        
        if let startDate = dto.dates.first?.startDate,
           let startTime = dto.dates.first?.startTime {

            let dateTimeString = "\(startDate) \(startTime)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            if let parsedDate = dateFormatter.date(from: dateTimeString) {
                self.date = parsedDate
            } else {
                self.date = Date()
            }
        } else if let startTimestamp = dto.dates.first?.start {
            self.date = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
        } else {
            self.date = Date()
        }
        
        let locationName = dto.location?.name ?? dto.location?.slug ?? ""
        let placeTitle = dto.place?.title ?? ""
        
        self.place = locationName + placeTitle
        
        self.coords = dto.place?.coords.toCLLocationCoordinate2D ?? CLLocationCoordinate2D()
        self.image = dto.images.first?.image ?? "cardImg1"
    }
}


