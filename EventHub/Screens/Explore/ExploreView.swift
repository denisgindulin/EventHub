//
//  ExploreView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var viewModel: ExploreViewModel
    
    
    init(exploreAPIService: IAPIServiceForExplore) {
        self._viewModel = StateObject(wrappedValue: ExploreViewModel(apiService: exploreAPIService)
        )
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                Color.appMainBackground // zIndex modifire // UIScreen.main.bounds.width
                VStack {
                    ZStack {
                        
                        CustomToolBar(
                            searchText: $viewModel.searchText,
                            currentLocation: $viewModel.currentLocation,
                            title: $viewModel.currentPosition,
                            magnifierColor: .white,
                            notifications: true,
                            filterAction: viewModel.filterEvents(orderType:),
                            locations: viewModel.locations)
 
                        CategoryScroll(categories:
                                        viewModel.categories,
                                       onCategorySelected: { selectedCategory in
                            viewModel.currentCategory = selectedCategory.category.slug ;
                            viewModel.upcomingEvents = []
                            
                            Task {
                                await viewModel.fetchUpcomingEvents()
                            }
                        })
                        .offset(y: 87)
                        
                        // LVL2
                        FunctionalButtonsView(names: viewModel.functionalButtonsNames, chooseButton: $viewModel.choosedButton)
                            .offset(y: 155)
                        
                    }
                    .zIndex(1)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            MainCategorySectionView(title: "Upcomimg Events")
                                .padding(.bottom, 10)
                            
                            if viewModel.upcomingEvents.isEmpty {
                                ScrollEventCardsView(events: nil, showDetail: viewModel.showDetail)
                                    .padding(.bottom, 10)
                            } else {
                                ScrollEventCardsView(events: viewModel.upcomingEvents, showDetail: viewModel.showDetail)
                                    .padding(.bottom, 10)
                            }
                            
                            MainCategorySectionView(title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            if viewModel.nearbyYouEvents.isEmpty {
                                ScrollEventCardsView(
                                    events: nil,
                                    showDetail: viewModel.showDetail)
                                .padding(.bottom, 250) // tabBer
                            } else {
                                ScrollEventCardsView(
                                    events: viewModel.nearbyYouEvents,
                                    showDetail: viewModel.showDetail)
                                .padding(.bottom, 250) // tabBer
                            }
                            
                        }
                        .offset(y: 100)
                    }
                    .offset(y: -10)
                    .zIndex(0)
                    .navigationBarHidden(true)
                }
            }
            .ignoresSafeArea()
        }
        .task {
            await viewModel.fetchCategories()
            await viewModel.fetchLocations()
            await viewModel.fetchUpcomingEvents()
            await viewModel.featchNearbyYouEvents()
        }
    }
}

#Preview {
    
}
