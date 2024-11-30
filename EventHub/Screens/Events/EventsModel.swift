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
        
        // Устанавливаем изображение
        self.image = dto.images.first?.image ?? "cardImg1"
    }
}
