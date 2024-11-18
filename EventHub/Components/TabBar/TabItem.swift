//
//  TabItem.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//

import Foundation

enum TabItem: String, CaseIterable {
    case explore
    case events
    case bookmark
    case map
    case profile
    
    var title: String {
        switch self {
        case .explore:
            return "Explore"
        case .events:
            return "Events"
        case .map:
            return "Map"
        case .profile:
            return "Profile"
        case .bookmark:
            return ""
        }
    }
    
    var icon: String {
        switch self {
        case .explore:
            return "explore"
            
        case .events:
            return "events"
            
        case .map:
            return "map"
            
        case .profile:
            return "profile"
        case .bookmark:
            return "bookmark"
        }
    }
}

