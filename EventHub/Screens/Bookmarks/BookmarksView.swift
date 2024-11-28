//
//  BookmarksView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct BookmarksView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject var viewModel: BookmarksViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: BookmarksViewModel())
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
