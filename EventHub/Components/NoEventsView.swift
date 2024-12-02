//
//  NoEventsView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 02.12.2024.
//

import SwiftUI

struct NoEventsView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            Image(systemName: "xmark.shield")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.appBlue)
                .frame(width: 150, height: 150 )
                .padding(20)
            
            Text("No events".uppercased())
                .foregroundStyle(.red)
                .airbnbCerealFont(AirbnbCerealFont.book, size: 24)
            
            Text("( in this category )")
                .foregroundStyle(.red)
                .airbnbCerealFont(AirbnbCerealFont.book, size: 14)
        }
        .frame(width: 237, height: 255)
    }
}

#Preview {
    NoEventsView()
}
