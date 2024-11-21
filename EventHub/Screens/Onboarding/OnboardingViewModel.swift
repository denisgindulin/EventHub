//
//  OnboardingViewModel.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 19.11.2024.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var currentStep = 0
    
    let onboardingItems = [
        OnboardingItem(image: "onboarding1", title: "Explore Upcoming and Nearby Events", description: "In publishing and graphic design, Lorem is a placeholder text commonly"),
        OnboardingItem(image: "onboarding2", title: "Web Have Modern Events Calendar Feature", description: "In publishing and graphic design, Lorem is a placeholder text commonly"),
        OnboardingItem(image: "onboarding3", title: "To Look Up More Events or Activities Nearby By Map", description: "In publishing and graphic design, Lorem is a placeholder text commonly"),
    ]
    
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
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}