//
//  BookmarksView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject var viewModel: FavoritesViewModel
    @State private var showSearchFlow = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: FavoritesViewModel())
    }
    
    var body: some View {
        VStack {
            ToolBarView(
                title: "Favorites".localized,
                foregroundStyle: .titleFont,
                isTitleLeading: false,
                showBackButton: false,
                actions: [
                    ToolBarAction(
                        icon: ToolBarButtonType.search.icon,
                        action: { showSearchFlow = true },
                        hasBackground: false,
                        foregroundStyle: .titleFont
                    )
                ]
            )
            Spacer()
            if coreDataManager.events.isEmpty {
                NoFavorites()
            } else {
                FavoriteEventsList()
            }
            Spacer()
        }
        .overlay(
            NavigationLink(
                destination: SearchView(
                    searchScreenType: .withData,
                    localData: coreDataManager.events.map { ExploreModel(event: $0) }
                ),
                isActive: $showSearchFlow,
                label: { EmptyView() }
            )
        )
        //        .toolbar {
        //            Button {
        //                print("Search")
        //            } label: {
        //                Image(.search)
        //                    .resizable()
        //                    .scaledToFit()
        //            }
        //
        //        }
        //        .navigationTitle("Favorites")
        //        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FavoritesView()
        .environmentObject(CoreDataManager())
}
