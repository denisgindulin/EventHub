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
            description: "Choose festivals, performances and other events and interesting places in your city and beyond"
        ),
        OnboardingItem(
            image: "onboarding2",
            title: "Web Have Modern Events Calendar Feature",
            description: "Сhoose an excursion, exhibition, stand-up show or other entertainment for the coming weekend or upcoming holidays"
        ),
        OnboardingItem(
            image: "onboarding3",
            title: "To Look Up More Events or Activities Nearby By Map",
            description: "An immersive show, a football match, or the opening of a new cafe may be taking place near you"
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
