//
//  NoFavorites.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 26.11.2024.
//

import SwiftUI

struct NoFavorites: View {
    var body: some View {
        VStack(spacing: 50) {
            Text("No favorites".uppercased())
                .airbnbCerealFont(.bold, size: 24)
            ZStack {
                Image(.noFavorites)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 140)
                Image(systemName: "xmark")
                    .font(.system(size: 60, weight: .ultraLight))
                    .padding(.bottom, 40)
                    .foregroundStyle(.appRed)
            }
        }
    }
}
