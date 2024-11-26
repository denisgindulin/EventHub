//
//  BackBarButtonView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//
import SwiftUI

struct BackBarButtonView: View {
    
    // MARK: - Properties
    var backActions: () -> Void
    let foregroundStyle: Color = .black
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let iconSize: CGFloat = 24
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: { backActions() }) {
            Image(systemName: ToolBarButtonType.back.icon)
                .resizable()
                .scaledToFit()
                .frame(width: Drawing.iconSize, height: Drawing.iconSize)
                .foregroundStyle(foregroundStyle)
        }
    }
}
