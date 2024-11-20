//
//  SmallEventCard.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 20.11.2024.
//

import SwiftUI

struct SmallEventCard: View {
    let image: String
    let date: Date
    let title: String
    let place: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 92)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(date.formattedDate())
                    .airbnbCerealFont(.book, size: 13)
                    .foregroundStyle(.appBlue)
                Text(title)
                    .airbnbCerealFont(.bold, size: 15)
                    .foregroundStyle(.titleFont)
                HStack {
                    Image(.mapPin)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                    Text(place)
                        .airbnbCerealFont(.book, size: 13)
                }
                .foregroundStyle(.appDarkGray)
            }
        }
        .padding(7)
        .background(.appBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .titleFont.opacity(0.1), radius: 8, x: 0, y: 10)
    }
}

#Preview {
    SmallEventCard(image: "cardImg1",
                   date: .now,
                   title: "Jo Malone London’s Mother’s Day Presents",
                   place: "Radius Gallery • Santa Cruz, CA")
}
