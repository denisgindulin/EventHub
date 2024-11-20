struct ToolBarAction: Identifiable {
    let id = UUID()
    let icon: String
    let action: () -> Void
    let hasBackground: Bool
    let foregroundStyle: Color
}

enum ToolBarButton {
    case back
    case search
    case bookmark
    case moreVertically
    
    var icon: String {
        switch self {
        case .back:
            return "arrow.left"
        case .bookmark:
            return "bookmarkFill"
        case .search:
            return "search"
        case .moreVertically:
            return "moreVertical"
        }
    }
}