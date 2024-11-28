//
//  EventModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import Foundation

struct ExploreEvent: Identifiable {
    let id: Int
    let title: String
    let visitors: [Visitor]?
    let date: Date
    let adress: String
    let image: String?
    
    static let example = ExploreEvent(
        id: 123,
        title: "Internationl Band Muzzzzz",
        visitors: [Visitor(image: "visitor", name: "Sonya"),
                   Visitor(image: "visitor", name: "Sonya"),
                   Visitor(image: "visitor", name: "Sonya"),
                   // Visitor(image: "visitor", name: "Sonya"),
                   // Visitor(image: "visitor", name: "Sonya"),
                   // Visitor(image: "visitor", name: "Sonya"),
                   Visitor(image: "visitor", name: "Sonya")],
        date: .now,
        adress: "36 Guild Street London, UK",
        image: "cardImg1")
}

extension ExploreEvent {
    init(dto: EventDTO) {
        self.id = dto.id
        self.title = dto.title ?? "No Title"
        self.visitors = dto.participants?.map { participant in
            Visitor(
                image: participant.agent?.images?.first ?? "default_visitor_image",
                name: participant.agent?.title ?? "No participant"
            )
        }
        self.date = (Date(timeIntervalSince1970: TimeInterval(dto.dates.first?.start ?? 1489312800)))
        self.adress = dto.place?.address ?? "Unknown Address"
        self.image = dto.images.first?.image
    }
}

struct Visitor: Identifiable {
    let id = UUID()
    let image: String
    let name: String
}
