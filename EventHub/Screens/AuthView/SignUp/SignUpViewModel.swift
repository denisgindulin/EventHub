//
//  SignUpViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct SignUpActions {
    let closed: CompletionBlock
}

class SignUpViewModel: ObservableObject {
    let actions: SignUpActions
    
    init(actions: SignUpActions) {
        self.actions = actions
    }
}
