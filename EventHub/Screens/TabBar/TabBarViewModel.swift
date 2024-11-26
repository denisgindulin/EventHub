//
//  TabBarViewModel.swift
//  EventHub
//
//  Created by Руслан on 22.11.2024.
//

import SwiftUI

struct TabBarActions {
    let showEventsView: CompletionBlock
    let showFavoritesView: CompletionBlock
    let showMapView: CompletionBlock
    let showProfileView:CompletionBlock
    let showExploreView: CompletionBlock
    let close: CompletionBlock
}

class TabBarViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = .explore
    let actions: TabBarActions
    
    init(actions: TabBarActions) {
        self.actions = actions
    }
    
    func switchTab(_ tab: Tab) {
        selectedTab = tab
    }
    
    func showEventsView() {
        actions.showEventsView()
    }
    
    func showExploverView() {
        actions.showExploreView()
    }
    
    func showProfileView() {
        actions.showProfileView()
    }
    
    func showMapView() {
        actions.showMapView()
    }
    
    func showFavoritesView() {
        actions.showFavoritesView()
    }

}
