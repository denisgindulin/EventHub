//
//  ContentView.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI
import Swinject

struct MaintView: View {
    @EnvironmentObject var router: NavigationRouter
    let container: Container
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch router.selectedTab {
                case .explore:
                    container.resolve(ExploreView.self, argument: ExploreActions())!
                case .events:
                    container.resolve(EventsView.self, argument: EventsActions())!
                case .favorites:
                    container.resolve(FavoritesView.self, argument: FavoritesViewActions())!
                case .map:
                    container.resolve(MapView.self, argument: MapViewActions())!
                case .profile:
                    container.resolve(ProfileView.self, argument: ProfileActions())!
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            TabBarView()
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
