//
//  SearchBarView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var searchString = "" // Bind
    
    let magnifierColor: Color // explore and search bar button color
    
    // func search result
    
    var body: some View {
        
        HStack {
            Button {
                // fetch search result
            } label: {
                Image(.search)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing,10)
                    .foregroundStyle(magnifierColor)
            }
            
            Rectangle()
                .frame(width: 1, height: 20)
                .foregroundStyle(.appPurple)
            
            TextField("Search...", text: $searchString)
            
            FiltersButtonView(color: .appPurple)
        }
//        .background(Color.appBlue) // for preview
        
    }
}

#Preview {
    SearchBarView(magnifierColor: .white)
}
