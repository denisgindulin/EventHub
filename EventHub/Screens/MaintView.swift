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
#warning("добавить переход на детальный экран")
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch router.selectedTab {
                case .explore:
                    container.resolve(
                        ExploreView.self,
                        argument: ExploreActions(
                            showDetail: {},
                            closed: {})
                    )!
                case .events:
                    container.resolve(EventsView.self, argument: EventsActions())!
                case .bookmark:
                    container.resolve(BookmarksView.self, argument: BookmarksViewActions())!
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
