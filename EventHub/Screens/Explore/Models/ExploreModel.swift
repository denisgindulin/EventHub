//
//  ExploreModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import Foundation

protocol EventConvertible {
    var id: Int { get }
    var title: String { get }
    var eventDate: Date { get }
    var adress: String { get }
    var image: String? { get }
}


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

extension ExploreModel: EventConvertible {
    var eventDate: Date { self.date }
}

extension ExploreModel {
    init(dto: EventDTO) {
        self.id = dto.id
        self.title = dto.title?.capitalized ?? "No Title"
        self.visitors = dto.participants?.map { participant in
            Visitor(
                image: participant.agent?.images?.first?.image ?? "default_visitor_image",
                name: participant.agent?.title ?? "No participant"
            )
        }
        
        let currentDate = Date()
        let closestDate = dto.dates
            .filter { $0.start != nil }
            .map { Date(timeIntervalSince1970: TimeInterval($0.start!)) }
            .filter { $0 > currentDate }
            .min(by: { abs($0.timeIntervalSince(currentDate)) < abs($1.timeIntervalSince(currentDate)) })
        
        self.date = closestDate ?? Date(timeIntervalSince1970: 1489312800)
        let location = dto.location?.name ?? ""
        let place = dto.place?.address ?? ""
        self.adress = "\(place), \(location)"
        self.image = dto.images.first?.image
    }
}

extension ExploreModel {
    init(movieDto: MovieDTO) {
        self.id = movieDto.id
        self.title = movieDto.title
        self.visitors = []
        self.date = (Date(timeIntervalSince1970: TimeInterval(movieDto.year)))
        self.adress = movieDto.site_url
        self.image = movieDto.poster.image
    }
}
    
extension ExploreModel {
    init(listDto: ListDTO) {
        self.id = listDto.id
        self.title = listDto.title
        self.visitors = []
        self.date = listDto.publicationDate
        self.adress = listDto.siteURL
        self.image = listDto.siteURL
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

extension ExploreModel {
    init(event: EventModel) {
        self.id = event.id
        self.title = event.title
        self.visitors = []
        self.date = event.date
        self.adress = event.location
        self.image = event.image
    }
}

extension ExploreModel {
    init(event: FavoriteEvent) {
        self.id = event.id
        self.title = event.title ?? "No Title"
        self.visitors = []
        self.date = event.date ?? Date()
        self.adress = event.adress ?? "Unknown Address"
        self.image = event.image
    }
}

struct EventIdentifier: Hashable {
    let id: Int
    let title: String
}

extension ExploreModel {
    static func filterExploreEvents(_ events: [ExploreModel]) -> [ExploreModel] {
        let currentDate = Date()
        var seenIdsAndTitles: Set<EventIdentifier> = []
        
        let groupedEvents = Dictionary(grouping: events) { EventIdentifier(id: $0.id, title: $0.title) }
        
        let filteredEvents = groupedEvents.values.compactMap { group -> ExploreModel? in
            group.filter { $0.date >= currentDate }
                 .min(by: { abs($0.date.timeIntervalSince(currentDate)) < abs($1.date.timeIntervalSince(currentDate)) })
        }
        
        return filteredEvents.filter { event in
            let eventPair = EventIdentifier(id: event.id, title: event.title)
            if seenIdsAndTitles.contains(eventPair) {
                return false
            } else {
                seenIdsAndTitles.insert(eventPair)
                return true
            }
        }
    }
}

struct Visitor: Identifiable {
    let id = UUID()
    let image: String
    let name: String
}
