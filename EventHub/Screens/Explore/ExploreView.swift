//
//  ExploreView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject private var viewModel: ExploreViewViewModel
    
    // MARK: - Init
    init(apiService: IEventAPIService) {
        self._viewModel = StateObject(wrappedValue: ExploreViewViewModel(apiService: apiService))
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                Color.appMainBackground // zIndex // UIScreen.main.bounds.width
                VStack {
                    ZStack {
                        CustomToolBar(
                            title: viewModel.currentPosition,
                            magnifierColor: .white
                        )
                        
                        CategoryScroll(categories: viewModel.categories)
                            .offset(y: 92)
                    }
                    .zIndex(1)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            MainCategorySectionView(title: "Upcomimg Events")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: nil)
                                .padding(.bottom, 10)
                            
                            MainCategorySectionView(title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: viewModel.events)
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
            await viewModel.fetchCategories()
            await viewModel.fetchLocations()
            await viewModel.fetchEvents()
        }
    }
}

#Preview {
    ExploreView(apiService: EventAPIService())
}
