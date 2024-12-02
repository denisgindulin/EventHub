//
//  ExploreModel.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 02.12.2024.
//

import Foundation

struct DetailEventModel: Identifiable {
    let id: Int
    let title: String
    let startDate: Date
    let endDate: Date
    let participants: [Participant]
    let description: String
    let bodyText: String
    let adress: String
    let location: String
    let image: String?
}

extension DetailEventModel: EventConvertible {
    var eventDate: Date { self.startDate }
}

extension DetailEventModel {
    init(dto: EventDTO) {
        self.id = dto.id
        self.title = dto.title ?? "No Title"
       
        let currentDate = Date()
        let closestDate = dto.dates
            .filter { $0.start != nil }
            .map { Date(timeIntervalSince1970: TimeInterval($0.start!)) }
            .filter { $0 > currentDate }
            .min(by: { abs($0.timeIntervalSince(currentDate)) < abs($1.timeIntervalSince(currentDate)) })
        self.startDate = closestDate ?? Date(timeIntervalSince1970: 1489312800)
   
        let endTimestamp = dto.dates.last?.end
        self.endDate = Date(timeIntervalSince1970: TimeInterval(endTimestamp ?? 1489312800))
        self.description = dto.description ?? "No Description"
        self.bodyText = dto.bodyText ?? "No Body Text"
        self.participants = dto.participants ?? []
        self.adress = dto.place?.title ?? "Unknown Address"
        self.location = dto.place?.address ?? "Unknown Location"
        self.image = dto.images.first?.image
    }
}
