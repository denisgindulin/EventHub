//
//  TabBarViewModel.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//

import Foundation

final class TabBarViewModel: ObservableObject {
    @Published var tabSelection: TabItem = .explore
    
    let pages: [TabItem] = TabItem.allCases
    
    init(tabSelection: TabItem) {
        self.tabSelection = tabSelection
    }
}

