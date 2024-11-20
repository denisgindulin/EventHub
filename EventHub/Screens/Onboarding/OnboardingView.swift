//
//  OnboardingView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 19.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
            VStack(spacing: 0) {
                OnboardingTabView(currentStep: $viewModel.currentStep, onboardingItems: viewModel.onboardingItems)
                OnboardingControlsView(currentStep: $viewModel.currentStep, totalSteps: viewModel.onboardingItems.count, skipAction: viewModel.skip, nextAction: viewModel.nextStep)
            }
        
    }
}

#Preview {
    OnboardingView()
}
