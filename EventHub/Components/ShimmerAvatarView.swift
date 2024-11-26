//
//  ShimmerAvatarView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 25.11.2024.
//

import SwiftUI

struct ShimmerAvatarView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 24, height: 24)
                .foregroundStyle(.fieldGray)
            Circle()
                .frame(width: 19, height: 19)
                .foregroundStyle(.appLightGray)
                .shimmering()
            Image(systemName: "face.dashed")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.purple)
                .shimmering()
            
        }
    }
}

#Preview {
    ShimmerAvatarView()
}
