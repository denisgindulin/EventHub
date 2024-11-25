//
//  BookmarkButton.swift
//  EventHub
//
//  Created by Денис Гиндулин on 25.11.2024.
//

import SwiftUI

struct BookmarkButton: View {
    let isFavorite: Bool
    var width: CGFloat
    var height: CGFloat
    
    init(isFavorite: Bool, width: CGFloat, height: CGFloat) {
        self.isFavorite = isFavorite
        self.width = UIScreen.main.bounds.width * width / 375
        self.height = UIScreen.main.bounds.height * height / 812
    }
    
    var body: some View {
        Image(isFavorite ? .bookmarkRedFill : .bookmarkOverlay)
            .resizable()
            .frame(width: width, height: height)
            .padding()
    }
}

#Preview {
    ZStack {
        Color(.orange).ignoresSafeArea()
            .opacity(0.5)
        
        VStack {
            //            BookmarkWithBgButton(event: Event.example)
            BookmarkButton(isFavorite: true, width: 16, height: 16)
            BookmarkButton(isFavorite: false, width: 16, height: 16)
        }
    }
}
