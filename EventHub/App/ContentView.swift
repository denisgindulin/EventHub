//
//  ContentView.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var tabBarViewModel = TabBarViewModel(tabSelection: .explore)
    private let apiService = EventAPIService()
    
    var body: some View {
        VStack(spacing: 0) {
            // Content for the selected tab
            selectedView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.appBackground.ignoresSafeArea())
            
            // Custom TabBar
            TabBarView(viewModel: tabBarViewModel)
        }
    }
    
    @ViewBuilder
    private func selectedView() -> some View {
        switch tabBarViewModel.tabSelection {
        case .explore:
            ExploreView(apiService: apiService)
        case .events:
            TestView()
        case .map:
            MapView()
        case .profile:
            ProfileView()
        case .bookmark:
            BookmarkView()
        }
    }
}

// MARK: - Dummy Views for Tabs
struct EventsView: View {
    var body: some View {
        VStack(spacing: 0) {
            ToolBarView(
                title: "Events"
            )
            .zIndex(1)
            Spacer()
            
            Text("Events View")
                .font(.largeTitle)
                .foregroundColor(.green)
            Spacer()
        }
    }
}

struct MapView: View {
    var body: some View {
        Text("Map View")
            .font(.largeTitle)
            .foregroundColor(.orange)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile View")
            .font(.largeTitle)
            .foregroundColor(.purple)
    }
}

struct BookmarkView: View {
    var body: some View {
        Text("Bookmark View")
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
