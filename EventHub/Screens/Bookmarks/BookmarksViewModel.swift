//
//  FavoritesViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct BookmarksViewActions {
//    let closed: CompletionBlock
}

class BookmarksViewModel: ObservableObject {
    @Published var events: [EventDTO] = []
    let actions: BookmarksViewActions
    
    init(actions: BookmarksViewActions) {
        self.actions = actions
    }
}
