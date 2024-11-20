//
//  CategoryScroll.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct CategoryScroll: View {
    
    let colors: [Color]
    let categoryNames: [String]
    let categoryImages: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<4) { number in
                    CategoryButtonView(categoryName: categoryNames[number], imageName: categoryImages[number], backgroundColor: colors[number])
                }
            }
            .padding(.leading, 24)
        }
    }
}

#Preview {
    CategoryScroll(colors: [.red, .orange, .green, .blue], categoryNames: ["Sports", "Music", "Food", "More"], categoryImages: ["ball", "music"," eat", "profile"])
}
