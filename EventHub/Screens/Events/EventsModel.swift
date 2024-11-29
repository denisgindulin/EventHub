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
        
        let locationName = dto.location?.name ?? dto.location?.slug ?? ""
        let placeTitle = dto.place?.title ?? ""
        self.location = locationName + placeTitle
        
        if let dateString = dto.dates.first?.startDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: dateString) {
                self.date = date
            } else {
                self.date = Date()
            }
        } else if let startTimestamp = dto.dates.first?.start {
            self.date = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
        } else {
            self.date = Date()
        }
        
        self.image = dto.images.first?.image ?? "cardImg1" 
    }
}
