//
//  FavoritesViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct FavoritesViewActions {
//    let closed: CompletionBlock
}

class FavoritesViewModel: ObservableObject {
    let actions: FavoritesViewActions
    
    init(actions: FavoritesViewActions) {
        self.actions = actions
    }
}
