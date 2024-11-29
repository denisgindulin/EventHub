//
//  ExploreView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var viewModel: ExploreViewModel
    
    @State private var isSearchPresented: Bool = false
    @State private var selectedEventID: Int? = nil
    @State private var isDetailPresented: Bool = false
    @State private var isSeeAllUpcomingEvents: Bool = false
    @State private var isSeeAllNearbyEvents: Bool = false
    
    //    MARK: - INIT
    init() {
        self._viewModel = StateObject(wrappedValue: ExploreViewModel()
        )
    }
    
    // MARK: - BODY
    var body: some View {
            ZStack {
                Color.appMainBackground // zIndex // UIScreen.main.bounds.width
                VStack(spacing: 0) {
                    ZStack {
                        
                        CustomToolBar(searchText: $viewModel.searchText,
                                      currentLocation: $viewModel.currentLocation,
                                      title: $viewModel.currentPosition,
                                      isSearchPresented: $isSearchPresented,
                                      notifications: true,
                                      filterAction:  { orderType in
                            viewModel.filterEvents(orderType: orderType)
                        } ,
                                      magnifierColor: .white,
                                      textColor: .white,
                                      placeholderColor: .searchBarPlaceholder,
                                      action:
                                        { Task {
                            await viewModel.fetchSearchedEvents()
                        }
                        } ,
                                      locations: viewModel.locations)
                        
                        CategoryScroll(categories:
                                        viewModel.categories,
                                       onCategorySelected: { selectedCategory in
                            viewModel.currentCategory = selectedCategory.category.slug ;
                            viewModel.upcomingEvents = []
                            viewModel.nearbyYouEvents = []
                        })
                        .offset(y: 87)
                        
                        // LVL2
                        FunctionalButtonsView(names: viewModel.functionalButtonsNames, chooseButton: $viewModel.choosedButton)
                            .offset(y: 155)
                    }
                    .zIndex(1)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            MainCategorySectionView(isPresented: $isSeeAllUpcomingEvents, title: "Upcomimg Events" /*viewModel.searchText + " - " + String(viewModel.searchedEvents.count)*/)
                                .padding(.bottom, 10)
                            
                            if viewModel.upcomingEvents.isEmpty {
                                ScrollEventCardsView(events: nil, showDetail: {_ in }
                                )
                                    .padding(.bottom, 10)
                            } else {
                                ScrollEventCardsView(events: viewModel.upcomingEvents,
                                                     showDetail: { event in
                                    selectedEventID = event
                                    isDetailPresented = true
                                })
                                    .padding(.bottom, 10)
                            }
                            
                            MainCategorySectionView(isPresented: $isSeeAllNearbyEvents, title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            if viewModel.nearbyYouEvents.isEmpty {
                                ScrollEventCardsView(
                                    events: nil,
                                    showDetail:{_ in})
                                .padding(.bottom, 250) // tabBer
                            } else {
                                ScrollEventCardsView(
                                    events: viewModel.nearbyYouEvents,
                                    showDetail: { event in
                                        selectedEventID = event
                                        isDetailPresented = true
                                    })
                                .padding(.bottom, 250) // tabBer
                            }
                        }
                        .offset(y: 100)
                    }
//                    .offset(y: -10)
                    .zIndex(0)
                    .navigationBarHidden(true)
                }
                .ignoresSafeArea()
            }
        // //
            .overlay(
                NavigationLink(
                    destination: SeeAllEventsView(events: viewModel.upcomingEvents),
                    isActive : $isSeeAllUpcomingEvents )
                {
                    EmptyView()
                }
            )
        // //
            .overlay(
                NavigationLink(
                    destination: SeeAllEventsView(events: viewModel.nearbyYouEvents),
                    isActive : $isSeeAllNearbyEvents )
                {
                    EmptyView()
                }
            )
        // //
            .overlay(
                NavigationLink(
                    destination: SearchView(text: $viewModel.searchText, events: viewModel.searchedEvents, action: { Task {
                        await viewModel.fetchSearchedEvents()
                    }
                    }),
                    isActive : $isSearchPresented )
                {
                    EmptyView()
                }
            )
            .overlay(
                    NavigationLink(
                        destination: DetailView(detailID: selectedEventID ?? 0),
                        isActive: $isDetailPresented
                    ) {
                        EmptyView()
                    }
                )
        .task {
            await viewModel.fetchCategories()
            await viewModel.fetchLocations()
            await viewModel.fetchUpcomingEvents()
            await viewModel.featchNearbyYouEvents()
        }
    }
}

#Preview {
    ExploreView()
}
