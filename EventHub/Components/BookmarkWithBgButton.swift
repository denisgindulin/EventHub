//
//  BookmarkWithBgButton.swift
//  EventHub
//
//  Created by Денис Гиндулин on 24.11.2024.
//

import SwiftUI

struct BookmarkWithBgButton: View {
    var isFavorite: Bool
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Button (action: action) {
                Image(isFavorite ? .bookmarkRedFill : .bookmarkOverlay)
                    .resizable()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: geometry.size.width / 2))
            }
        }
    }
}

#Preview {
    ZStack {
        Color(.orange).ignoresSafeArea()
            .opacity(0.5)
        
        VStack {
            BookmarkWithBgButton(isFavorite: true, action: {})
                .frame(width: 30, height: 30)
                .padding(.bottom, 50)
            BookmarkWithBgButton(isFavorite: false, action: {})
                .frame(width: 30, height: 30)
        }
    }
}
