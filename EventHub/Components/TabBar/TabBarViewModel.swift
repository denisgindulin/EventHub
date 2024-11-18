//
//  TabBarViewModel.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//

import Foundation

final class TabBarViewModel: ObservableObject {
    @Published var tabSelection: Int = 0
    
    @Published var pages: [TabItem] = {
        [
            TabItem.events,
            TabItem.explore,
            TabItem.map,
            TabItem.profile
        ]
    }()
    
}

