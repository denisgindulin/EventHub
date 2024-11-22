//
//  ToolBarButtonView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//

import SwiftUI

struct ToolBarButtonView: View {
    
    // MARK: - Properties
    let action: ToolBarAction
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let cornerRadius: CGFloat = 10
        static let backgroundOpacity: Double = 0.3
        static let buttonSize: CGFloat = 36
        static let iconSize: CGFloat = 24
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: action.action) {
            ZStack {
                if action.hasBackground {
                    RoundedRectangle(cornerRadius: Drawing.cornerRadius)
                        .fill(Color.white.opacity(Drawing.backgroundOpacity))
                        .frame(width: Drawing.buttonSize, height: Drawing.buttonSize)
                        .background(.ultraThinMaterial)
                }
                Image(action.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Drawing.iconSize, height: Drawing.iconSize)
                    .foregroundStyle(action.foregroundStyle)
            }
        }
    }
}
