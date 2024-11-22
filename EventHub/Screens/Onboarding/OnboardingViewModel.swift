//
//  OnboardingViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import Combine

struct OnboardingActions {
    let showSignIn: CompletionBlock
    let showSignUp: CompletionBlock
    let closed: CompletionBlock
}

class OnboardingViewModel: ObservableObject {
    let actions: OnboardingActions
    
    init(actions: OnboardingActions) {
        self.actions = actions
    }
    
    func showSignInView() {
        actions.showSignIn()
    }
    
    func showSignUpView() {
        actions.showSignUp()
    }
    
    func close() {
        actions.closed()
    }
}
