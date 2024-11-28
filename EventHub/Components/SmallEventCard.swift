//
//  SmallEventCard.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 20.11.2024.
//

import SwiftUI
import Kingfisher

struct SmallEventCard: View {
    let image: String
    let date: Date
    let title: String
    let place: String
    let showPlace: Bool
    let showBookmark: Bool
    let bookmarkAction: (() -> Void)?
    
    init(image: String, date: Date, title: String, place: String, showPlace: Bool = true, showBookmark: Bool = false, bookmarkAction: (() -> Void)? = nil) {
        self.image = image
        self.date = date
        self.title = title
        self.place = place
        self.showPlace = showPlace
        self.showBookmark = showBookmark
        self.bookmarkAction = bookmarkAction
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top, spacing: 18) {
                let url = URL(string: image)
                KFImage(url)
                    .placeholder {
                        ShimmerView(ratio: 1.6)
                            .scaledToFit()
                            .frame(width: 80, height: 92)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 92)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack( alignment: .leading, spacing: 4) {
                    Text(showPlace ? date.formattedDate(format: "E, MMM d • h:mm a") : date.formattedWithSuffix())
                        .airbnbCerealFont(showPlace ? .book : .medium, size: 13)
                        .foregroundStyle(.appBlue)
                    
                    Text(title)
                        .airbnbCerealFont(.bold, size: 15)
                        .foregroundStyle(.titleFont)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    if showPlace {
                        HStack {
                            Image(.mapPin)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                            Text(place)
                                .airbnbCerealFont(.book, size: 13)
                                .lineLimit(1)
                        }
                        .foregroundStyle(.appDarkGray)
                    }
                }
                Spacer()
            }
            .padding(7)
            .frame(maxWidth: .infinity)
            .background(.appBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .titleFont.opacity(0.1), radius: 8, x: 0, y: 10)
            
            if showBookmark {
                VStack {
                    Button {
                        bookmarkAction?()
                    } label: {
                        Image(.bookmarkRedFill)
                            .foregroundStyle(.appRed)
                    }
                }
                .padding(8)
            }
        }
    }
}

#Preview {
    SmallEventCard(image: "cardImg1",
                   date: .now,
                   title: "Jo Malone London’s Mother’s Day Presents",
                   place: "Radius Gallery • Santa Cruz, CA", showBookmark: true)
}
