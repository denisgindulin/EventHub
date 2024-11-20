//
//  ToolBarView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//

import SwiftUI

// MARK: - ToolBarView
struct ToolBarView: View {
    
    // MARK: - Properties
    var title: String
    var foregroundStyle: Color = .black
    
    var isTitleLeading: Bool = false
    var showBackButton: Bool = false
    var actions: [ToolBarAction]
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let tabBarHeight: CGFloat = 80
        static let titleFontSize: CGFloat = 24
        static let spacingBetweenButtons: CGFloat = 16
        static let leadingSpacing: CGFloat = 24
        static let trailingSpacing: CGFloat = 24
        static let titleLeadingSpacing: CGFloat = 13
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            if showBackButton {
                BackBarButtonView()
                    .padding(.leading, Drawing.leadingSpacing)
            }
            
            // Title
            Text(title)
                .airbnbCerealFont(
                    AirbnbCerealFont.medium,
                    size: Drawing.titleFontSize
                )
                .lineLimit(1)
                .frame(
                    maxWidth: .infinity,
                    alignment: isTitleLeading ? .leading : .center
                )
                .padding(.leading, isTitleLeading && showBackButton ? Drawing.titleLeadingSpacing : 0)
            
            Spacer(minLength: 0)
            
            // Right Buttons
            HStack(spacing: Drawing.spacingBetweenButtons) {
                ForEach(actions) { action in
                    ToolBarButtonView(action: action)
                }
            }
            .padding(.trailing, Drawing.trailingSpacing)
        }
        .frame(height: Drawing.tabBarHeight)
    }
}

struct ToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarView(
            title: "Toolbar Title",
            isTitleLeading: true,
            showBackButton: true,
            actions: [
                ToolBarAction(
                    icon: ToolBarButtonType.search.icon,
                    action: { print("Search tapped") },
                    hasBackground: false,
                    foregroundStyle: .white
                ),

                ToolBarAction(
                    icon: ToolBarButtonType.moreVertically.icon,
                    action: { print("More tapped") },
                    hasBackground: false,
                    foregroundStyle: .black
                )
            ]
        )
    }
}



