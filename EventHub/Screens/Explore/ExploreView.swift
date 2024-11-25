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
                            searchText: $model.searchText,
                            title: model.currentPosition,
                            magnifierColor: .white,
                            notifications: true,
                            filterAction: model.filterEvents(orderType:))
                    
                        CategoryScroll(categories:
                                        model.categories,
                                       onCategorySelected: { selectedCategory in
                            model.currentCategory = selectedCategory.category.slug
                            
                            Task {
                                await model.fetchUpcomingEvents()
                            }
                        })
                        .offset(y: 92)
                    }
                    .zIndex(1)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            MainCategorySectionView(title: "Upcomimg Events")
                                .padding(.bottom, 10)
                            
                            if model.upcomingEvents.isEmpty {
                                ScrollEventCardsView(events: nil, showDetail: model.showDetail)
                                    .padding(.bottom, 10)
                            } else {
                                ScrollEventCardsView(events: model.upcomingEvents, showDetail: model.showDetail)
                                    .padding(.bottom, 10)
                            }
                            
                            MainCategorySectionView(title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            if model.upcomingEvents.isEmpty {
                                ScrollEventCardsView(
                                    events: nil,
                                    showDetail: model.showDetail)
                                .padding(.bottom, 150) // tabBer
                            } else {
                                ScrollEventCardsView(
                                    events: model.nearbyYouEvents,
                                    showDetail: model.showDetail)
                                .padding(.bottom, 150) // tabBer
                            }
                            
                            
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
            await model.fetchUpcomingEvents()
            await model.featchNearbyYouEvents()
        }
    }
}

#Preview {
    ExploreView(model: ExploreViewModel(
        actions: ExploreActions(showDetail: {_ in },
                                closed: {}),
        apiService: EventAPIService()))
}
