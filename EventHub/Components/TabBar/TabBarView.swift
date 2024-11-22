//
//  TabBarView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//
import SwiftUI

struct TabBarView: View {
    @ObservedObject var viewModel: TabBarViewModel
    @Namespace private var animationNamespace
    
    // MARK: - Drawing Constants
    private enum Drawing {
        static let tabBarHeight: CGFloat = 80
        static let tabBarCornerRadius: CGFloat = 20
        static let iconSize: CGFloat = 23
        static let floatingButtonSize: CGFloat = 64
        static let floatingButtonOffsetY: CGFloat = -32
        static let shadowRadius: CGFloat = 8
        static let fontSize: CGFloat = 12
        static let buttonSize: CGFloat = 43
    }
    
    // MARK: - Body
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
                // Left buttons
                ForEach(viewModel.pages.prefix(2), id: \.rawValue) { page in
                    let isSelected = page == viewModel.tabSelection
                    createTabBarButton(
                        imageName: page.icon,
                        buttonLabel: page.title,
                        isSelected: isSelected
                    )
                    .onTapGesture {
                        switchToTab(page)
                    }
                }
                
                // Center bookmark button
                bookmarkButton(isSelected: viewModel.tabSelection == .bookmark)
                
                // Right buttons
                ForEach(viewModel.pages.suffix(2), id: \.rawValue) { page in
                    let isSelected = page == viewModel.tabSelection
                    createTabBarButton(
                        imageName: page.icon,
                        buttonLabel: page.title,
                        isSelected: isSelected
                    )
                    .onTapGesture {
                        switchToTab(page)
                    }
                }
            }
            .frame(height: Drawing.tabBarHeight)
            .padding(.horizontal, calculateEdgeSpacing())
        }
    }
    
    // MARK: - Bookmark Button
    private func bookmarkButton(isSelected: Bool) -> some View {
        Button {
            withAnimation(.easeInOut) {
                viewModel.tabSelection = .bookmark
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(isSelected ? .appRed : .appBlue)
                    .frame(width: Drawing.floatingButtonSize, height: Drawing.floatingButtonSize)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                
                Image(TabItem.bookmark.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Drawing.iconSize, height: Drawing.iconSize)
                    .foregroundColor(.white)
            }
        }
        .offset(y: Drawing.floatingButtonOffsetY)
    }
    
    // MARK: - Tab Bar Button
    private func createTabBarButton(imageName: String, buttonLabel: String, isSelected: Bool) -> some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Drawing.iconSize, height: Drawing.iconSize)
            
            if !buttonLabel.isEmpty {
                Text(buttonLabel)
                    .airbnbCerealFont(
                        AirbnbCerealFont.medium,
                        size: Drawing.fontSize
                    )
            }
        }
        .frame(width: Drawing.buttonSize)
        .foregroundColor(isSelected ? .appBlue : .gray)
    }
    
    // MARK: - Switch Tab
    private func switchToTab(_ tab: TabItem) {
        withAnimation(.easeInOut) {
            viewModel.tabSelection = tab
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

// MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: TabBarViewModel(tabSelection: .explore))
    }
}
