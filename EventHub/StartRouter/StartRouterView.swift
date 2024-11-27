//
//  StartRouterView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 27.11.2024.
//


import SwiftUI

struct StartRouterView: View {
    @StateObject var startRouter = StartRouter()
    let newsAPIManager = EventAPIService()
    
    var body: some View {
        Group {
            switch startRouter.routerState {
            case .onboarding:
                OnboardingView(router: startRouter)
            case .auth:
                SignInView(router: startRouter)
            case .main:
                EventHubContentView(
                    router: startRouter,
                    eventAPIManager: newsAPIManager
                )
            }
        }
        .transition(.opacity)
        .animation(.bouncy, value: startRouter.routerState)
    }
}

#Preview {
    StartRouterView()
}
