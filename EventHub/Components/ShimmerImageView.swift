//
//  SwiftUIView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 25.11.2024.
//

import SwiftUI

struct ShimmeringImageView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.fieldGray)
                .frame(width: 218, height: 131)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.appLightGray)
                    .frame(width: 208, height: 121)
                    .shimmering()
                
                Text("Image loading ...")
                    .foregroundStyle(.purple)
                    .airbnbCerealFont(AirbnbCerealFont.book, size: 18)
                    .shimmering()
            }
        }
    }
}

#Preview {
    ShimmeringImageView()
}
