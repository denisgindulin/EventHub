//
//  DisplayOrderType.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 25.11.2024.
//


enum DisplayOrderType: CaseIterable {
    case alphabetical
    case date

    var name: String {
        switch self {
        case .alphabetical:
            return "alphabetical".localized
        case .date:
            return "by date".localized
        }
    }
}
