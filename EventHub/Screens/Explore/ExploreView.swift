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
                    
                    CustomToolBar(
                        currentLocation: $viewModel.currentLocation,
                        title: $viewModel.currentPosition,
                        isSearchPresented: $isSearchPresented,
                        isNotifications: true,
                        filterAction:  { orderType in
                            viewModel.filterEvents(orderType: orderType)
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
                        
                        MainCategorySectionView(isPresented: $isSeeAllUpcomingEvents, title: "Upcomimg Events", linkActive: !viewModel.emptyUpcoming /*viewModel.searchText + " - " + String(viewModel.searchedEvents.count)*/)
                            .padding(.bottom, 10)
                        
                        if viewModel.emptyUpcoming {
                            NoEventsView()
                        } else {
                            ScrollEventCardsView(emptyArray: false, events: viewModel.upcomingEvents,
                                                                            showDetail: { event in
                                                           selectedEventID = event
                                                           isDetailPresented = true
                                                       })
                                                       .padding(.bottom, 10)
                        }
                        
                        MainCategorySectionView(isPresented: $isSeeAllNearbyEvents, title: "Nearby You", linkActive: !viewModel.emptyNearbyYou)
                            .padding(.bottom, 10)
                        
                        if viewModel.emptyNearbyYou {
                            NoEventsView()
                                .padding(.bottom, 180)
                        } else {
                            ScrollEventCardsView(emptyArray: false, events: viewModel.nearbyYouEvents,
                                                                            showDetail: { event in
                                                           selectedEventID = event
                                                           isDetailPresented = true
                                                       })
                                                       .padding(.bottom, 180)
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
      
        .overlay(
            NavigationLink(
                destination: SearchView(searchScreenType: .withoutData),
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

//#Preview {
//    ExploreView()
//}
