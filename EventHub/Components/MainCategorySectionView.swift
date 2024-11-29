//
//  MainCategorySectionView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct MainCategorySectionView: View {
    let title : String
    var body: some View {
        HStack {
            Text(title)
                .airbnbCerealFont(AirbnbCerealFont.medium, size: 18)
                .frame(width: 160, height: 24, alignment: .leading)
                .foregroundStyle(.black) // Color
                .opacity(0.84)
            
            Spacer()
            
            Button{
                // see All View
            } label: {
                Text("See All")
                    .frame(height: 23)
                    .airbnbCerealFont(AirbnbCerealFont.medium, size: 14)
                    .foregroundStyle(.gray)
                    .padding(.trailing, 16)
            }
        }
        .padding(.leading,24)
    }
}

#Preview {
    MainCategorySectionView(title: "Upcoming Events")
}

