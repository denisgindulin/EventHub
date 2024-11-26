//
//  CategoryButtonView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

//struct CategoryButtonView: View {
//    
//    
//    let categoryName: String
//    let imageName: String
//    let backgroundColor: Color
//    
//   
//    var body: some View {
//        
//        Button{
//          //
//        } label: {
//            HStack {
//                Image(imageName)
//                    .resizable()
//                    .frame(width: 18, height: 18)
//                    .foregroundStyle(.white)
//                
//                Text(categoryName)
//                    .airbnbCerealFont( AirbnbCerealFont.book, size: 15)
//                    .foregroundStyle(Color.white)
//                    .frame( height: 20)
//            }
//            .padding(.horizontal, 16)
//            .frame( height: 40)
//            .background(backgroundColor)
//            .clipShape(Capsule())
//        }
//    }
//}

struct CategoryButtonView: View {
    let categoryName: String
    let imageName: String
    let backgroundColor: Color
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.white)
                
                Text(categoryName)
                    .airbnbCerealFont(AirbnbCerealFont.book, size: 15)
                    .foregroundStyle(Color.white)
                    .frame(height: 20)
            }
            .padding(.horizontal, 16)
            .frame(height: 40)
            .background(backgroundColor)
            .clipShape(Capsule())
            
        }
    }
}

#Preview {
    CategoryButtonView( categoryName: "Sports", imageName: "hiking", backgroundColor: .appRed, onTap: {})
}
