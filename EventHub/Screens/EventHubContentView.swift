//
//  ContentView.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI
//import Swinject

struct EventHubContentView: View {
    @State private var selectedTab: Tab = .explore
    private let router: StartRouter
    private let eventAPIManager: IEventAPIService
    
    
    init(router: StartRouter, eventAPIManager: IEventAPIService) {
        self.router = router
        self.eventAPIManager = eventAPIManager
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
                        EventsView(eventAPIService: eventAPIManager)
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
            TabBarView(selectedTab: $selectedTab, switchTab: switchTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    

}
