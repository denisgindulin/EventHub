//
//  TabBarView.swift
//  EventHub
//
//  Created by Руслан on 21.11.2024.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        HStack {
            TabBarButton(tab: .explore, iconName: "magnifyingglass", title: "Explore")
            TabBarButton(tab: .events, iconName: "calendar", title: "Events")
            TabBarButton(tab: .favorites, iconName: "star", title: "Favorites")
            TabBarButton(tab: .map, iconName: "map", title: "Map")
            TabBarButton(tab: .profile, iconName: "person", title: "Profile")
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
    
    private func TabBarButton(tab: Tab, iconName: String, title: String) -> some View {
        Button(action: {
            router.switchTab(tab)
        }) {
            VStack {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .foregroundColor(router.selectedTab == tab ? .blue : .gray)
                Text(title)
                    .font(.footnote)
                    .foregroundColor(router.selectedTab == tab ? .blue : .gray)
            }
            .padding(.horizontal, 16)
        }
    }
}
