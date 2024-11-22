//
//  SignInViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct SignInActions {
    let showMainScreen: () -> ()
    let closed: CompletionBlock
}

class SignInViewModel: ObservableObject {
    let actions: SignInActions
    
    init(actions: SignInActions) {
        self.actions = actions
    }
    
    func showMainView() {
        actions.showMainScreen()
    }
    
    func close() {
        actions.closed()
    }
}
