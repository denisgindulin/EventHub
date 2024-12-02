//
//  SmallEventCard 2.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 02.12.2024.
//


import SwiftUI
import Kingfisher

struct SmallEventCardForMovie: View {

    let image: String
    let title: String
    let url: String
    
    init(image: String,  title: String, url: String) {
        self.image = image
        self.title = title
        self.url = url
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top, spacing: 18) {
                let imageURL = URL(string: image)
                KFImage(imageURL)
                    .placeholder {
                        ShimmeringImageView()
                            .scaledToFit()
                            .frame(width: 80, height: 92)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .onFailureImage(UIImage(named: "cardImg1"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 92)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(title)
                        .airbnbCerealFont(.bold, size: 15)
                        .foregroundStyle(.titleFont)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    // Ссылка для перехода на страницу фильма
                    Link(destination: URL(string: url)!) {
                        HStack {
                            Text(url)
                                .airbnbCerealFont(.medium, size: 12)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                            Image(systemName: "arrow.up.right.square.fill")
                                .foregroundStyle(.appBlue)
                        }
                    }
                }
                Spacer()
            }
            .padding(7)
            .frame(maxWidth: .infinity)
            .background(.appBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .titleFont.opacity(0.1), radius: 8, x: 0, y: 10)
        }
    }
}

#Preview {
    SmallEventCardForMovie(image: "cardImg1", title: "Jo Malone London’s Mother’s Day Presents", url: "https://kudago.com/movie/astral-medium/")
}

