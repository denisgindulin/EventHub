//
//  TabBarView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//
import SwiftUI

// MARK: - TabBarView
struct TabBarView: View {
    
    @ObservedObject var viewModel: TabBarViewModel
    @Namespace private var animationNamespace
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let tabBarHeight: CGFloat = 88
        static let tabBarCornerRadius: CGFloat = 20
        static let iconSize: CGFloat = 24
        static let iconPadding: CGFloat = 16
        static let floatingButtonSize: CGFloat = 64
        static let floatingButtonOffset: CGFloat = -32
        static let shadowRadius: CGFloat = 8
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                // Background with shadow
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: Drawing.tabBarHeight)
                
                    .shadow(
                        color: Color.black.opacity(0.1),
                        radius: Drawing.shadowRadius,
                        x: 0,
                        y: -2
                    )
                
                // Tab bar items
                HStack(spacing: 0) {
                    Spacer()
                    ForEach(viewModel.pages.prefix(2), id: \.rawValue) { page in
                        let isSelected = viewModel.pages.firstIndex(of: page) == viewModel.tabSelection
                        Spacer()
                        createTabBarButton(
                            imageName: page.icon,
                            buttonLabel: page.title,
                            isSelected: isSelected
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if let index = viewModel.pages.firstIndex(of: page) {
                                    viewModel.tabSelection = index
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    bookmarkButton
                    
                    Spacer()
                    
                    ForEach(viewModel.pages.suffix(2), id: \.rawValue) { page in
                        let isSelected = viewModel.pages.firstIndex(of: page) == viewModel.tabSelection
                        Spacer()
                        createTabBarButton(
                            imageName: page.icon,
                            buttonLabel: page.title,
                            isSelected: isSelected
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if let index = viewModel.pages.firstIndex(of: page) {
                                    viewModel.tabSelection = index
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .frame(height: Drawing.tabBarHeight)
        }
    }
    
    // MARK: - Bookmark Button
    private var bookmarkButton: some View {
        Button {
            withAnimation(.easeInOut) {
                viewModel.tabSelection = viewModel.pages.firstIndex { $0.icon ==   TabItem.bookmark.rawValue } ?? 0
            }
        } label: {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: Drawing.floatingButtonSize, height: Drawing.floatingButtonSize)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                
                Image(TabItem.bookmark.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
            }
        }
        .offset(y: Drawing.floatingButtonOffset)
    }
    
    // MARK: - Tab Bar Button
    private func createTabBarButton(imageName: String, buttonLabel: String, isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Drawing.iconSize, height: Drawing.iconSize)
            
            if !buttonLabel.isEmpty {
                Text(buttonLabel)
                    .font(.caption)
            }
        }
        .foregroundColor(isSelected ? .blue : .gray)
        .padding(.vertical, Drawing.iconPadding)
    }
}

// MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: TabBarViewModel())
    }
}
