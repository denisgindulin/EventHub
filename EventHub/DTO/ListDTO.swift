//
//  ListItemModel.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 02.12.2024.
//


import Foundation

struct ListDTO: Codable, Identifiable, Sendable, DecodableType {
    let id: Int
    let publicationDate: Date
    let title: String
    let slug: String
    let siteURL: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case publicationDate = "publication_date"
        case title
        case slug
        case siteURL = "site_url"
    }
}

struct ResponseListDTO: Codable, Sendable, DecodableType {
    let results: [ListDTO]
}
