//
//  CategoryButtonView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct CategoryButtonView: View {
    
    let categoryName: String
    let imageName: String
    let backgroundColor: Color
    
    // func
    
    var body: some View {
        
        Button{
            // fetch category results
        } label: {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 18, height: 18)
                
                Text(categoryName)
                    .airbnbCerealFont( AirbnbCerealFont.book, size: 15)
                    .foregroundStyle(Color.white)
                    .frame(width: 47, height: 20)
            }
            .padding(.horizontal, 16)
            .frame(width: 107, height: 40)
            .background(backgroundColor)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    CategoryButtonView(categoryName: "Sports", imageName: "ball", backgroundColor: .appRed)
}
