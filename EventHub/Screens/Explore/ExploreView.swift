//
//  ExploreView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject var model: ExploreViewModel
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                Color.appMainBackground // zIndex // UIScreen.main.bounds.width
                VStack {
                    ZStack {
                        
                        CustomToolBar(
                            title: model.currentPosition,
                            magnifierColor: .white,
                            notifications: true, getSearchString: {} // передать поисковую строку
                            
                        )
                        
                        CategoryScroll(categories:
                                        model.categories,
                                       onCategorySelected: { selectedCategory in
                            model.currentCategory = selectedCategory.category.slug // отдаем на сервер name или slug ?
                            
                            Task {
                                await model.fetchEvents()
                            }
                        })
                        .offset(y: 92)
                    }
                    .zIndex(1)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            MainCategorySectionView(title: "Upcomimg Events")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: model.events, showDetail: model.showDetail)
                                .padding(.bottom, 10)
                            
                            MainCategorySectionView(title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: model.events, showDetail: model.showDetail)
                                .padding(.bottom, 150) // for TabBar
                        }
                        .offset(y: 25)
                    }
                    .offset(y: -10)
                    .zIndex(0)
                    .navigationBarHidden(true)
                }
            }
            .ignoresSafeArea()
        }
        .task {
            await model.fetchCategories()
            await model.fetchLocations()
            await model.fetchEvents()
        }
    }
}

#Preview {
    ExploreView(model: ExploreViewModel(
        actions: ExploreActions(showDetail: {_ in },
                                closed: {}),
        apiService: EventAPIService()))
}
