//
//  CategoryScroll.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct CategoryScroll: View {
    
    let categories: [CategoryUIModel]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories) { category in
                    CategoryButtonView(
                        categoryName: category.category.name,
                        imageName: category.image,
                        backgroundColor: category.color
                    )
                }
                .clipped()
                
            }
            .padding(.leading, 24)
        }
    }
}

#Preview {
    CategoryScroll(categories: [])
}
