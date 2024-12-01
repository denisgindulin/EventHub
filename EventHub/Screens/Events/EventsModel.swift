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
            "UPCOMING".localized
        case .pastEvents:
            "PAST EVENTS".localized
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
        
        if let startDate = dto.dates.last?.startDate,
           let startTime = dto.dates.last?.startTime {

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
