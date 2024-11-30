//
//  Event.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 30.11.2024.
//


import Foundation

struct EventSearchResponse: Codable, Sendable, DecodableType  {
    let count: Int
    let next: String?
    let previous: String?
    let results: [SearchEventDTO]
}

struct SearchEventDTO: Codable, Identifiable, Sendable, DecodableType {
    let id: Int
    let title: String
    let description: String
    let itemURL: String
    let imageURL: String
    let place: Place?
    let ageRestriction: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, description
        case itemURL = "item_url"
        case imageURL = "first_image"
        case place
        case ageRestriction = "age_restriction"
    }
}

struct Place: Codable, Sendable, DecodableType {

    let title: String
    let address: String
    let subway: String?
}
