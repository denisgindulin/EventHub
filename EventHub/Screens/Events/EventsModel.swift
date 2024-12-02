//
//  EventsModel.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 26.11.2024.
//

import Foundation

enum EventsMode: CaseIterable {
    case upcoming
    case pastEvents
    
    var title: String {
        switch self {
        case .upcoming:
            "UPCOMING"
        case .pastEvents:
            "PAST EVENTS"
        }
    }
}

struct EventModel: Identifiable {
    var id: Int 
    let title: String
    let location: String
    let date: Date
    let image: String
}

extension EventModel {
    init(dto: EventDTO) {
        self.id = dto.id
        self.title = dto.title ?? ""
        
        let location = dto.location?.name ?? ""
        let place = dto.place?.address ?? ""
        self.location = "\(String(describing: place)), \(String(describing: location))"
        
        let currentDate = Date()
        let closestDate = dto.dates
            .filter { $0.start != nil }
            .map { Date(timeIntervalSince1970: TimeInterval($0.start!)) }
            .filter { $0 > currentDate }
            .min(by: { abs($0.timeIntervalSince(currentDate)) < abs($1.timeIntervalSince(currentDate)) })
        
        self.date = closestDate ?? Date(timeIntervalSince1970: 1489312800)
        
        // Устанавливаем изображение
        self.image = dto.images.first?.image ?? "cardImg1"
    }
}
