//
//  MapViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct MapViewActions {
//    let closed: CompletionBlock
}

class MapViewModel: ObservableObject {
    let actions: MapViewActions
    
    init(actions: MapViewActions) {
        self.actions = actions
    }
}

