//
//  ExploreViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct ExploreActions {
//    let closed: CompletionBlock
}

class ExploreViewModel: ObservableObject {
    let actions: ExploreActions
    
    init(actions: ExploreActions) {
        self.actions = actions
    }
}
