//
//  ToolBarAction.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//

import SwiftUI

// MARK: - ToolBarAction
struct ToolBarAction: Identifiable {
    // MARK: - Properties
    let id = UUID()
    let icon: String
    let action: () -> Void
    let hasBackground: Bool
    let foregroundStyle: Color
}

// MARK: - ToolBarButtonType
enum ToolBarButtonType {
    // MARK: - Cases
    case back
    case search
    case bookmark
    case bookmarkFill

    
    // MARK: - Icon
    var icon: String {
        switch self {
        case .back:
            return "arrow.left"
        case .bookmark:
            return "bookmarkOverlay"
        case .bookmarkFill:
            return "bookmarkFill"
        case .search:
            return "search"
        }
    }
}
