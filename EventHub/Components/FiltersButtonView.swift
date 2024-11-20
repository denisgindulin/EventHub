//
//  FiltersButtonView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct FiltersButtonView: View {
    
    // some func
    
    let color: Color // explore and search bar button color
    
    var body: some View {
        Button {
            // show filters func
        } label: {
            HStack {
                Image(.filter)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("Filters")
                    .frame(width: 35, height: 16, alignment: .leading)
                    .airbnbCerealFont( AirbnbCerealFont.book, size: 12)
                    .foregroundStyle(Color.white)
                    .padding(.trailing,1)
            }
            .padding(5)
            .frame(width: 75, height: 32.1)
            .background(color)
            .clipShape(Capsule())
            
        }
    }
}

#Preview {
    FiltersButtonView(color: Color.appPurple)
}
