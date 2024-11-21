//
//  DetailComponentView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI

struct DetailComponentView: View {
    let image: String
    let title: String
    let description: String
    
    let showImgBg: Bool
    
    init(image: String, title: String, description: String, showImgBg: Bool = true) {
        self.image = image
        self.title = title
        self.description = description
        self.showImgBg = showImgBg
    }
    
    var body: some View {
        HStack {
            if showImgBg {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 25, maxHeight: 25)
                    .padding(10)
                    .background(.appBlue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image(image)
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
