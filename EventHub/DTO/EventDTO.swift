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

    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case startTime = "start_time"
    }
}

// MARK: - Place
struct Place: Codable, Sendable, DecodableType {
    let id: Int
    let title: String
    let slug: String
    let address: String
    let coords: Coordinates
    let location: String

    enum CodingKeys: String, CodingKey {
        case id, title, slug, address
        case coords
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
    let title: String?
    let language: Language?
}

// MARK: - Participant
struct Participant: Codable {
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
    let title: String
    let slug: String
    let agentType: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id,  title, slug
        case agentType = "agent_type"
        case images
    }
}

enum Language: String, Codable, DecodableType {
    case ru, eng
}
