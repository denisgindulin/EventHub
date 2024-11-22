//
//  ProfileViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct ProfileActions {
//    let closed: CompletionBlock
}

class ProfileViewModel: ObservableObject {
    let actions: ProfileActions
    
    init(actions: ProfileActions) {
        self.actions = actions
    }
}
