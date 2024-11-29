//
//  TabBarView.swift
//  EventHub
//
//  Created by Руслан on 21.11.2024.
//

import SwiftUI

// MARK: - Tab Enum
enum Tab: String, CaseIterable {
    case explore
    case events
    case favorites
    case map
    case profile
    
    // MARK: - Title for Tabs
    var title: String {
        switch self {
        case .explore:
            return "Explore"
        case .events:
            return "Events"
        case .map:
            return "Map"
        case .profile:
            return "Profile"
        case .favorites:
            return ""
        }
    }
    
    // MARK: - Icon for Tabs
    var icon: String {
        switch self {
        case .explore:
            return "explore"
        case .events:
            return "events"
        case .map:
            return "map"
        case .profile:
            return "profileTab"
        case .favorites:
            return "bookmark"
        }
    }
}

struct TabBarView: View {
    // MARK: - Properties
    @Binding var selectedTab: Tab
    var switchTab: (Tab) -> Void
    
    @Namespace private var animationNamespace
    
    // MARK: - Drawing Constants
    private enum Drawing {
        static let tabBarHeight: CGFloat = 88
        static let tabBarCornerRadius: CGFloat = 20
        static let iconSize: CGFloat = 23
        static let floatingButtonSize: CGFloat = 50
        static let floatingButtonOffsetY: CGFloat = -32
        static let shadowRadius: CGFloat = 8
        static let fontSize: CGFloat = 12
        static let buttonSize: CGFloat = 43
    }
    
    var body: some View {
        ZStack {
            // Background with shadow
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.appBackground)
                .frame(height: Drawing.tabBarHeight)
                .shadow(
                    color: Color.black.opacity(0.1),
                    radius: Drawing.shadowRadius,
                    x: 0,
                    y: -2
                )
            
            HStack(spacing: calculateSpacing()) {
                TabBarButton(tab: .explore, iconName: Tab.explore.icon, title: Tab.explore.title)
                TabBarButton(tab: .events, iconName: Tab.events.icon, title: Tab.events.title)
                BookmarkButton(tab: .favorites, iconName: Tab.favorites.icon)
                TabBarButton(tab: .map, iconName: Tab.map.icon, title: Tab.map.title)
                TabBarButton(tab: .profile, iconName: Tab.profile.icon, title: Tab.profile.title)
                
            }
            .frame(height: Drawing.tabBarHeight)
            .padding(.horizontal, calculateEdgeSpacing())
        }
    }
    
    
    // MARK: - Bookmark Button
    private func BookmarkButton(tab: Tab, iconName: String) -> some View {
        Button {
            withAnimation(.easeInOut) {
                switchTab(tab)
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(selectedTab == tab ? .appRed : .appBlue)
                    .frame(width: Drawing.floatingButtonSize, height: Drawing.floatingButtonSize)
                    .shadow(color: selectedTab == tab ? .appRed.opacity(0.3) : .appBlue.opacity(0.3), radius: 10, x: 0, y: 5)
                
                Image(iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Drawing.iconSize, height: Drawing.iconSize)
                    .foregroundColor(.white)
            }
        }
        .offset(y: Drawing.floatingButtonOffsetY)
    }
    
    // MARK: - Tab Bar Button
    private func TabBarButton(tab: Tab, iconName: String, title: String) -> some View {
        Button(action: {
           switchTab(tab)
        }) {
            VStack {
                Image(iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Drawing.iconSize, height: Drawing.iconSize)
                
                if !title.isEmpty {
                    Text(title)
                        .airbnbCerealFont(
                            AirbnbCerealFont.medium,
                            size: Drawing.fontSize
                        )
                }
            }
            .frame(width: Drawing.buttonSize)
            .foregroundColor(selectedTab == tab ? .appBlue : .gray)
        }
    }
    
    // MARK: - Spacing Calculations
    private func calculateSpacing() -> CGFloat {
        // Calculate spacing dynamically
        let totalWidth = UIScreen.main.bounds.width
        let numberOfItems = 5
        let totalItemWidth = CGFloat(numberOfItems - 1) * Drawing.iconSize + Drawing.floatingButtonSize
        let availableSpace = totalWidth - totalItemWidth
        return availableSpace / CGFloat(numberOfItems + 5)
    }
    
    private func calculateEdgeSpacing() -> CGFloat {
        // Equal spacing for edges
        return calculateSpacing() / 2
    }
    

}
