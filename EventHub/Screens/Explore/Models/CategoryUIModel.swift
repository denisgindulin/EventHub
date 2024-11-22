//
//  Category.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 22.11.2024.
//

import SwiftUI

struct CategoryUIModel: Identifiable {
    let id: Int
    let category: CategoryDTO
    let color: Color
    let image: String
    
    init(id: Int, category: CategoryDTO, color: Color, image: String) {
        self.id = category.id
        self.category = category
        self.color = color
        self.image = image
    }
}

enum CategoryImageMapping {
    static func image(for category: CategoryDTO) -> String {
        switch category.slug.lowercased() {
        case "business-events":
            return "briefcase"
        case "cinema":
            return "film"
        case "concert":
            return "music"
        case "education":
            return "book"
        case "entertainment":
            return "game_controller"
        case "exhibition":
            return "gallery"
        case "fashion":
            return "wardrobe"
        case "festival":
            return "eat"
        case "holiday":
            return "ball"
        case "kids":
            return "toy"
        case "other":
            return "other_category"
        case "party":
            return "party_hat"
        case "photo":
            return "camera"
        case "quest":
            return "magnifying_glass"
        case "recreation":
            return "hiking"
        case "shopping":
            return "shopping_bag"
        case "social-activity":
            return "heart_hands"
        case "stock":
            return "discount"
        case "theater":
            return "drama_masks"
        case "tour":
            return "tour_bus"
        case "yarmarki-razvlecheniya-yarmarki":
            return "market"
        default:
            return "default_category"
        }
    }
    
    static func color(for category: CategoryDTO) -> Color {
        switch category.slug.lowercased() {
        case "business-events":
            return .blue
        case "cinema":
            return .red
        case "concert":
            return .purple
        case "education":
            return .orange
        case "entertainment":
            return .cyan
        case "exhibition":
            return .green
        case "fashion":
            return .pink
        case "festival":
            return .yellow
        case "holiday":
            return .mint
        case "kids":
            return .teal
        case "other":
            return .gray
        case "party":
            return .appGreen
        case "photo":
            return .brown
        case "quest":
            return .indigo
        case "recreation":
            return .appRed
        case "shopping":
            return .appYellow
        case "social-activity":
            return .pink
        case "stock":
            return .purple
        case "theater":
            return .red
        case "tour":
            return .green
        case "yarmarki-razvlecheniya-yarmarki":
            return .orange
        default:
            return .gray
        }
    }
}
