//
//  MainCategorySectionView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct MainCategorySectionView: View {
    
    @Binding var isPresented: Bool
    let title : String
    
    var body: some View {
        HStack {
            Text(title.localized)
                .airbnbCerealFont(AirbnbCerealFont.medium, size: 18)
                .frame(width: 200, height: 24, alignment: .leading)
                .foregroundStyle(.black)
                .opacity(0.84)
            
            Spacer()
            
            NavigationLink {
                Text("See All View")
            } label: {
                Button{
                    isPresented = true
                } label: {
                    Text("See All")
                        .frame(height: 23)
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: 14)
                        .foregroundStyle(.gray)
                        .padding(.trailing, 16)
                }
            }
        }
        .padding(.leading,24)
    }
}

#Preview {
    MainCategorySectionView(isPresented: .constant(false), title: "Upcoming Events")
}

