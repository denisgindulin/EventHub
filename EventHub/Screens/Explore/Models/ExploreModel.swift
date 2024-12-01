//
//  ExploreModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import Foundation

struct ExploreModel: Identifiable {
    let id: Int
    let title: String
    let visitors: [Visitor]?
    let date: Date
    let adress: String
    let image: String?
    
    static let example = ExploreModel(
        id: 123,
        title: "International Band Music Concert",
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

extension ExploreModel {
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


extension ExploreModel {
    init(searchDTO: SearchResultDTO) {
        self.id = searchDTO.id
        self.title = searchDTO.title
        self.visitors = []
        self.date = (Date(timeIntervalSince1970: TimeInterval(searchDTO.daterange?.start ?? 1489312800)))
        self.adress = searchDTO.place?.address ?? "Unknown Address"
        self.image = searchDTO.firstImage?.image
    }
}

extension ExploreModel {
    init(model: MapEventModel) {
        self.id = model.id
        self.title = model.title
        self.visitors = []
        self.date = model.date
        self.adress = model.place
        self.image = model.image
    }
}

struct Visitor: Identifiable {
    let id = UUID()
    let image: String
    let name: String
}
