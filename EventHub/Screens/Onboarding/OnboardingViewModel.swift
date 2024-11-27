//
//  OnboardingViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    private let router: StartRouter
    @Published var currentStep = 0
    
    let onboardingItems = [
        OnboardingItem(
            image: "onboarding1",
            title: "Explore Upcoming and Nearby Events",
            description: "In publishing and graphic design, Lorem is a placeholder text commonly"
        ),
        OnboardingItem(
            image: "onboarding2",
            title: "Web Have Modern Events Calendar Feature",
            description: "In publishing and graphic design, Lorem is a placeholder text commonly")
        ,
        OnboardingItem(
            image: "onboarding3",
            title: "To Look Up More Events or Activities Nearby By Map",
            description: "In publishing and graphic design, Lorem is a placeholder text commonly"
        ),
    ]
    
    
    init(router: StartRouter) {
        self.router = router
    }
    
    func nextStep() {
        if currentStep < onboardingItems.count - 1 {
            currentStep += 1
        } else {
            completeOnboarding()
        }
    }
    
    func skip() {
        completeOnboarding()
    }
    
    private func completeOnboarding() {
    
        onboardingCompleted()
    }

    //MARK: - NavigationState
    func onboardingCompleted() {
        router.updateRouterState(with: .onboardingCompleted)
    }
}
