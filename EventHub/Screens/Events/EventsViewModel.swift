//
//  EventsViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct EventsActions {
//    let closed: CompletionBlock
}

class EventsViewModel: ObservableObject {
    let actions: EventsActions
    
    init(actions: EventsActions) {
        self.actions = actions
    }
}

