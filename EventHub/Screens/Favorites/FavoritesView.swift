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
    
    init() {
        self._viewModel = StateObject(wrappedValue: FavoritesViewModel())
    }
    
    var body: some View {
        VStack {
            ToolBarView(
                title: "Favorites",
                foregroundStyle: .titleFont,
                isTitleLeading: false,
                showBackButton: false,
                actions: [
                    ToolBarAction(
                        icon: ToolBarButtonType.search.icon,
                        action: {
                            //
                        },
                        hasBackground: false,
                        foregroundStyle: .titleFont
                    )
                ]
            )
            if coreDataManager.events.isEmpty {
                NoFavorites()
            } else {
                FavoriteEventsList()
            }
        }
    }
}
