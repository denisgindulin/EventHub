//
//  BookmarkWithBgButton.swift
//  EventHub
//
//  Created by Денис Гиндулин on 24.11.2024.
//

import SwiftUI

struct BookmarkWithBgButton: View {
//    let event: Event
    let isFavorite: Bool
    var width: CGFloat
    var height: CGFloat
    
    init(isFavorite: Bool, width: CGFloat, height: CGFloat) {
        self.isFavorite = isFavorite
        self.width = UIScreen.main.bounds.width * width / 375
        self.height = UIScreen.main.bounds.width * width / 375
    }
    

    
    var body: some View {
//        Image(event.isFavorite ? .bookmarkRedFill : .bookmarkOverlay)
        Image(isFavorite ? .bookmarkRedFill : .bookmarkOverlay)
            .resizable()
            .frame(width: width, height: height)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: width / 5))

        
//        ZStack {
//            RoundedRectangle(cornerRadius: 7)
//                .frame(width: 30, height: 30)
////                .foregroundStyle(.appOrangeSecondary)
//                .opacity(0.7)
//            Image(event.isFavorite ? .bookmarkRedFill : .bookmarkOverlay)
//                .resizable()
//                .frame(width: 14, height: 14)
////                .background(.secondary)
//                .background(.ultraThinMaterial)
//        }
    }
}

#Preview {
    ZStack {
        Color(.orange).ignoresSafeArea()
            .opacity(0.5)
        
        VStack {
            //            BookmarkWithBgButton(event: Event.example)
            BookmarkWithBgButton(isFavorite: false, width: 30, height: 30)
        }
    }
}
