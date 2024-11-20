//
//  CustomToolbar.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct CustomToolBar: View {
    
    let title: String
    let magnifierColor: Color
    let colors: [Color]
    let categories: [String]
    let pictures: [String]
    
    
    var body: some View {
            VStack {
                HStack{
                    VStack(alignment: .leading) {
                        Button {
                            // redefinition geo
                        } label: {
                            Text("Current Location")
                                .airbnbCerealFont( AirbnbCerealFont.book, size: 12)
                                .frame(width: 99, height: 14, alignment: .leading)
                                .foregroundStyle(Color.white)
                                .opacity(0.7)
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .frame(width: 10, height: 5)
                                .foregroundStyle(Color.white)
                                .opacity(0.7)
                        }
                        
                        Text(title)
                            .foregroundStyle(Color.white)
                            .airbnbCerealFont(AirbnbCerealFont.book, size: 13)
                    }
                    
                    Spacer()
                    
                    Button{
                        // show natifications
                    } label: {
                        Image(.bell)
                    }
                }
                .padding(.horizontal,24)
                .padding(.bottom, 10)
                
                SearchBarView(magnifierColor: magnifierColor)
                    .padding(.horizontal,24)
                
                CategoryScroll(colors: colors, categoryNames: categories, categoryImages: pictures)
                
            }
            .frame(width: .infinity, height: 190)
            .padding(0)
            .background(.appBlue)
            .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft,.bottomRight]))
            
            
               
        
    }
}
