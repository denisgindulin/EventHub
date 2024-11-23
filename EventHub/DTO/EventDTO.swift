//
//  EventDTO.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import Foundation

// MARK: - Response
struct APIResponseDTO: Codable, Sendable, DecodableType {
    let next: String?
    let previous: String?
    let results: [EventDTO]
}

// MARK: - Event
struct EventDTO: Codable, Identifiable, Sendable, DecodableType {
    let id: Int
    let dates: [EventDate]?
    let title: String?
    let slug: String?
    let place: Place?
    let description: String?
    let bodyText: String?
    let location: EventLocation?
    let categories: [String]?
    let tagline: String?
    let ageRestriction: String?
    let price: String?
    let isFree: Bool?
    let images: [ImageDTO]?
    let favoritesCount: Int?
    let commentsCount: Int?
    let siteURL: String?
    let shortTitle: String?
    let tags: [String]?
    let disableComments: Bool?
    let participants: [Participant]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case dates
        case title
        case slug
        case place
        case description
        case bodyText = "body_text"
        case location
        case categories
        case tagline
        case ageRestriction = "age_restriction"
        case price
        case isFree = "is_free"
        case images
        case favoritesCount = "favorites_count"
        case commentsCount = "comments_count"
        case siteURL = "site_url"
        case shortTitle = "short_title"
        case tags
        case disableComments = "disable_comments"
        case participants
    }
}

// MARK: - EventCategory
struct CategoryDTO: Codable, Identifiable, Sendable, DecodableType {
    let id: Int
    let slug: String
    let name: String
}

// MARK: - EventCategory
struct EventCategory: Codable, Identifiable, Sendable, DecodableType {
    let id: Int
    let slug: String
    let name: String
}

// MARK: - EventDate
struct EventDate: Codable, Sendable, DecodableType {
    let start: Int?
    let end: Int?
}

// MARK: - Place
struct Place: Codable, Sendable, DecodableType {
    let id: Int
}

// MARK: - Coordinates
struct Coordinates: Codable, Sendable, DecodableType {
    let lat: Double
    let lon: Double
}

// MARK: - Location
struct EventLocation: Codable, Sendable, DecodableType {
    let slug: String?
}

// MARK: - Participant
struct Participant: Codable {
    let role: Role?
    let agent: Agent?
}

// MARK: - Role
struct Role: Codable, Sendable, DecodableType {
    let slug: String?
}

// MARK: - Agent
struct Agent: Codable, Sendable, DecodableType {
    let id: Int
    let title: String?
    let slug: String?
    let agentType: String?
    let images: [String]?
    let siteURL: String?
    let isStub: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case agentType = "agent_type"
        case images
        case siteURL = "site_url"
        case isStub = "is_stub"
    }
}

enum Language: String, Codable, DecodableType {
    case ru, en
}

// MARK: - EventCategory

struct ImageDTO: Codable, Sendable, DecodableType {
    let image: String?
}
