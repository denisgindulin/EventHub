//
//  StartRouter.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 27.11.2024.
//


import Foundation
import FirebaseAuth

final class StartRouter: ObservableObject {
    
    // MARK: - Published Properties
    @Published var routerState: RouterState = .onboarding
    
//    private let storage = StorageManager.shared
//    private let authManager = FirebaseManager.shared
    
    // MARK: - State & Event Enums
    enum RouterState {
        case onboarding
        case auth
        case main
    }
    
    enum StartEvent {
        case onboardingCompleted
        case userAuthorized
        case userLoggedOut
    }
    
    // MARK: - Initializer
    init() {
        updateRouterState(with: .onboardingCompleted)
    }
    
    // MARK: - State Management
    private func reduce(_ state: RouterState, event: StartEvent) -> RouterState {
        var newState = state
        switch event {
        case .onboardingCompleted:
            newState = rootState(state: newState)
        case .userAuthorized:
            newState = .main
        case .userLoggedOut:
            newState = .onboarding
        }
        return newState
    }
    
    // MARK: - Public Methods
    func updateRouterState(with event: StartEvent) {
        Task {
            await MainActor.run {
                routerState = reduce(routerState, event: event)
            }
        }
    }
    
    // MARK: - Private Helpers
    private func rootState(state: RouterState) -> RouterState {
        var newState = state

        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")

        if hasCompletedOnboarding {
            newState = (Auth.auth().currentUser == nil) ? .main : .auth
        } else {
            newState = .onboarding
            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        }

        return newState
    }
}
