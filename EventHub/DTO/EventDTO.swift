//
//  EventDTO.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import Foundation

// MARK: - Response
struct APIResponseDTO: Codable, Sendable, DecodableType {
    let count: Int
    let next: String?
    let previous: String?
    let results: [EventDTO]
}

// MARK: - Event
struct EventDTO: Codable, Identifiable, Sendable, DecodableType {
        let id: Int
        let dates: [EventDate]
        let place: Place?
        let location: Location?
        let participants: [Participant]?
    }

// MARK: - EventCategory
struct EventCategory: Codable, Identifiable, Sendable, DecodableType {
    let id: Int
    let slug: String
    let name: String
}

// MARK: - EventDate
struct EventDate: Codable, Sendable, DecodableType {
    let startDate: String?
    let startTime: String?
    let start: Int
    let endDate: String?
    let endTime: String?
    let end: Int?


    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case startTime = "start_time"
        case start
        case endDate = "end_date"
        case endTime = "end_time"
        case end
    }
}

// MARK: - Place
struct Place: Codable, Sendable, DecodableType {
    let id: Int
    let title: String
    let slug: String
    let address: String
    let phone: String?
    let isStub: Bool
    let siteURL: String?
    let coords: Coordinates
    let subway: String?
    let isClosed: Bool
    let location: String

    enum CodingKeys: String, CodingKey {
        case id, title, slug, address, phone
        case isStub = "is_stub"
        case siteURL = "site_url"
        case coords, subway
        case isClosed = "is_closed"
        case location
    }
}

// MARK: - Coordinates
struct Coordinates: Codable, Sendable, DecodableType {
    let lat: Double
    let lon: Double
}

// MARK: - Location
struct Location: Codable, Sendable, DecodableType {
    let slug: String
    let name: String?
    let timezone: String?
    let coords: Coordinates?
    let language: Language?
    let currency: String?
}

// MARK: - Participant
struct Participant: Codable, Sendable, DecodableType {
    let role: Role
    let agent: Agent
}

// MARK: - Role
struct Role: Codable, Sendable, DecodableType {
    let id: Int
    let name: String
    let namePlural: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case namePlural = "name_plural"
    }
}

// MARK: - Agent
struct Agent: Codable, Sendable, DecodableType {
    let id: Int
    let ctype: String
    let title: String
    let slug: String
    let description: String
    let bodyText: String
    let rank: Double
    let agentType: String
    let images: [String]
    let favoritesCount: Int
    let commentsCount: Int
    let itemURL: String
    let disableComments: Bool

    enum CodingKeys: String, CodingKey {
        case id, ctype, title, slug, description
        case bodyText = "body_text"
        case rank
        case agentType = "agent_type"
        case images
        case favoritesCount = "favorites_count"
        case commentsCount = "comments_count"
        case itemURL = "item_url"
        case disableComments = "disable_comments"
    }
}

enum Language: String, Codable, DecodableType {
    case ru, eng
}
