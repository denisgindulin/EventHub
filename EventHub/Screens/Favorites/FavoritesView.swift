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
            if coreDataManager.events.isEmpty {
                NoFavorites()
            } else {
                FavoriteEventsList()
            }
        }
    }
}
