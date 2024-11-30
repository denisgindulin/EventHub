//
//  StartRouterView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 27.11.2024.
//


import SwiftUI

struct StartRouterView: View {
    @StateObject var startRouter = StartRouter()
    private let storage = DIContainer.resolve(forKey: .storageService) ?? UDStorageService()
    
    var body: some View {
        if startRouter.routerState !=
            .onboarding
            || storage.hasCompletedOnboarding()
        {
            Group {
                switch startRouter.routerState {
                case .onboarding:
                    OnboardingView(router: startRouter)
                case .auth:
                    NavigationView {
                        SignInView(router: startRouter)
                    }
                case .main:
                    EventHubContentView(router: startRouter)
                }
            }
            .transition(.opacity)
            .animation(.bouncy, value: startRouter.routerState)
        }
    }
}
#Preview {
    StartRouterView()
}
