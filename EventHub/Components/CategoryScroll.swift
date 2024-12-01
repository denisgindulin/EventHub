//
//  CategoryScroll.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI


struct CategoryScroll: View {
    let categories: [CategoryUIModel]
    let onCategorySelected: (CategoryUIModel) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories) { category in
                    CategoryButtonView(
                        categoryName: category.category.name,
                        imageName: category.image,
                        backgroundColor: category.color,
                        onTap: {
                            onCategorySelected(category)
                        }
                    )
                }
                .clipped()
            }
            .padding(.leading, 24)
        }
    }
}

#Preview {
    CategoryScroll(categories: [], onCategorySelected: {_ in })
}
