//
//  ImageDetailView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 30.11.2024.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    let imageUrl: String?
    
    var body: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .global).minY
            if let imageUrl = imageUrl,
               let url = URL(string: imageUrl) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 244 + (minY > 0 ? minY : 0))
                    .frame(width: proxy.size.width)
                    .overlay(Color.black.opacity(0.3))
            } else {
                Image(.cardImg1)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 244 + (minY > 0 ? minY : 0))
                    .frame(width: proxy.size.width)
                    .overlay(Color.black.opacity(0.3))
            }
        }
        .frame(height: 244)
    }
}
