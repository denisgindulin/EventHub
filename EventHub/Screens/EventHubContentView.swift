//
//  ContentView.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI

struct EventHubContentView: View {
    @State private var selectedTab: Tab = .explore
    private let router: StartRouter
    
    
    init(router: StartRouter) {
        self.router = router
    }
    
    func switchTab(_ tab: Tab) {
        selectedTab = tab
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .explore:
                    NavigationView {
                        ExploreView()
                    }
                case .events:
                    NavigationView {
                        EventsView()
                    }
                case .map:
                    NavigationView {
                        MapView()
                    }
                case .favorites:
                    NavigationView {
                        FavoritesView()
                    }
                case .profile:
                    NavigationView {
                        ProfileView(router: router)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.top)
            TabBarView(selectedTab: $selectedTab, switchTab: switchTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
