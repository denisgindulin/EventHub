//
//  EventModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import Foundation

struct Event: Identifiable {
    let id: Int
    let title: String
    let visitors: [Visitor]?
    let date: String
    let adress: String
    let image: String? // url/data ?
    let isFavorite: Bool
    
    static let example = Event(
        id: 123,
        title: "Internationl Band Muzzzzz",
        visitors: [Visitor(image: "visitor", name: "Sonya"),
                   Visitor(image: "visitor", name: "Sonya"),
                   Visitor(image: "visitor", name: "Sonya"),
                   // Visitor(image: "visitor", name: "Sonya"),
                   // Visitor(image: "visitor", name: "Sonya"),
                   // Visitor(image: "visitor", name: "Sonya"),
                   Visitor(image: "visitor", name: "Sonya")],
        date: "10 JUN",
        adress: "36 Guild Street London, UK",
        image: "cardImg1", isFavorite: true )
}

extension Event {
    init(dto: EventDTO, isFavorite: Bool) {
        self.id = dto.id
        self.title = dto.title ?? "No Title"
        self.visitors = dto.participants?.map { participant in
            Visitor(
                image: participant.agent?.images?.first ?? "default_visitor_image",
                name: participant.agent?.title ?? "No participant"
            )
        }
        self.date = dto.dates.first?.startDate ??
            (Date(timeIntervalSince1970: TimeInterval(dto.dates.first?.start ?? 1489312800)))
                .formattedDate(format: "dd\nMMM")
        self.adress = dto.place?.address ?? "Unknown Address"
        self.image = dto.images.first?.image
        self.isFavorite = isFavorite
    }
}

struct Visitor: Identifiable {
    let id = UUID()
    let image: String
    let name: String
}
