//
//  SearchEventDTO.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 01.12.2024.
//


import Foundation

// MARK: - Welcome
struct SearchResponseDTO: Codable, Sendable, DecodableType {
    let results: [SearchResultDTO]
}

// MARK: - Result
struct SearchResultDTO: Codable, Identifiable, Sendable, DecodableType  {
    let id: Int
    let slug, title: String
    let description: String
    let itemURL: String?
    let place: Place?
    let daterange: Daterange?
    let firstImage: FirstImage?

    enum CodingKeys: String, CodingKey {
        case id, slug, title
        case description
        case itemURL = "item_url"
        case place, daterange
        case firstImage = "first_image"
    }
}

// MARK: - Daterange
struct Daterange: Codable, Sendable {
    let start: Int?
    let end: Int?
    let startDate: Int?
    let startTime: Int?
    let endTime: Int?

    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case startTime = "start_time"
        case endTime = "end_time"
        case start
        case end
    }
}

// MARK: - FirstImage
struct FirstImage: Codable, Sendable, DecodableType  {
    let image: String
}


// MARK: - Place
struct Place: Codable, Identifiable, Sendable, DecodableType  {
    let id: Int
    let title, slug, address: String
    let coords: Coords
    let location: String
}

// MARK: - Coords
struct Coords: Codable, Sendable, DecodableType  {
    let lat, lon: Double
}
