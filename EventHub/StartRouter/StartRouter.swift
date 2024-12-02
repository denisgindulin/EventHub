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
    
    private let storage = DIContainer.resolve(forKey: .storageService) ?? UDStorageService()
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
            newState = .auth
        }
        return newState
    }
    
    // MARK: - Public Methods
    func updateRouterState(with event: StartEvent) {
        routerState = reduce(routerState, event: event)
    }
    
    // MARK: - Private Helpers
    private func rootState(state: RouterState) -> RouterState {
        var newState = state
        
        if storage.hasCompletedOnboarding() {
            if storage.getIsRememberMeOn() && Auth.auth().currentUser != nil {
                newState = .main
            } else {
                newState = (Auth.auth().currentUser != nil && !storage.getIsRememberMeOn()) ? .main : .auth
            }
        } else {
            newState = .onboarding
            storage.set(value: true as Bool, forKey: .hasCompletedOnboarding)
        }
        
        return newState
    }
}
