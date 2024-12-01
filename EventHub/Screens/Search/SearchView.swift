//
//  SearchView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 28.11.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    
    @State private var isSearchPresented = true
    
    // MARK: - Init
    init(searchScreenType: SearchScreenType,
         localData: [ExploreModel] = []
    ) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel(searchScreenType: searchScreenType, localData: localData))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.appBackground
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text("Search")
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: 24)
                    
                    SearchBarView(isSearchPresented: $isSearchPresented,
                                  searchText: $viewModel.searchText,
                                  textColor: .black,
                                  magnifierColor: .appBlue,
                                  shouldHandleTextInput: true,
                                  fiterAction: {_ in }
                    )
                    .padding(.horizontal,24)
                    .padding(.top, 30)
                }
                .zIndex(1)
                Spacer()
                
                if viewModel.searchResults.isEmpty {
                    Text("No results".uppercased())
                        .airbnbCerealFont(AirbnbCerealFont.bold, size: 26)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.searchResults) { event in
                                NavigationLink(destination: DetailView(detailID: event.id)) {
                                    SmallEventCard(
                                        image: event.image ?? "",
                                        date: event.date,
                                        title: event.title,
                                        place: event.adress,
                                        showPlace: false
                                    )
                                    .padding(.horizontal, 20)
                                    .padding(.bottom,5)
                                    
                                }
                                
                            }
                        }
                    }
                    .padding(.top,30)
                }
            }
            
        }
        .offset(y: -40)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBarButtonView(foregroundStyle: .black)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    SearchView(searchScreenType: .withoutData)
}
