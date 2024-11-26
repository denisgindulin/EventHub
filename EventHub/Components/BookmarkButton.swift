//
//  BookmarkButton.swift
//  EventHub
//
//  Created by Денис Гиндулин on 25.11.2024.
//

import SwiftUI

struct BookmarkButton: View {
    var isFavorite: Bool
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Button (action: action) {
                Image(isFavorite ? .bookmarkRedFill : .bookmarkOverlay)
                    .resizable()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
            }
        }
    }
}

#Preview {
    ZStack {
        Color(.orange).ignoresSafeArea()
            .opacity(0.5)
        
        VStack {
            BookmarkButton(isFavorite: true, action: {})
                .frame(width: 50, height: 50)
            BookmarkButton(isFavorite: false, action: {})
                .frame(width: 30, height: 30)
        }
    }
}
