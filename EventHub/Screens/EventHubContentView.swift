//
//  ContentView.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI
import Swinject

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
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .explore:
                ExploreView(exploreAPIService: eventAPIManager)
            case .events:
                EventsView(eventAPIService: eventAPIManager)
            case .map:
                MapView()
            case .bookmark:
                BookmarksView()
            case .profile:
                ProfileView(router: router)
            }
            TabBarView(selectedTab: $selectedTab, switchTab: switchTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    

}
