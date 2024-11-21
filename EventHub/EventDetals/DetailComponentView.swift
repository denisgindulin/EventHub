//
//  DetailComponentView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI

struct DetailComponentView: View {
    let image: Image
    let title: String
    let description: String
    
    let showImgBg: Bool
    
    init(image: Image, title: String, description: String, showImgBg: Bool = true) {
        self.image = image
        self.title = title
        self.description = description
        self.showImgBg = showImgBg
    }
    
    var body: some View {
        HStack {
            if showImgBg {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 25, maxHeight: 25)
                    .padding(10)
                    .background(.appBlue.opacity(0.1))
                    .foregroundStyle(.appBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 45, maxHeight: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .airbnbCerealFont(.medium)
                    .foregroundStyle(.titleFont)
                Text(description)
                    .airbnbCerealFont(.book, size: 12)
                    .foregroundStyle(.appDarkGray)
            }
        }
    }
}
