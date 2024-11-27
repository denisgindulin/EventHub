//
//  OnboardingView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel
    
    init(router: StartRouter) {
        self._viewModel = StateObject(wrappedValue: OnboardingViewModel(router: router))
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OnboardingTabView(
                currentStep: $viewModel.currentStep,
                onboardingItems: viewModel.onboardingItems
            )
            OnboardingControlsView(
                currentStep: $viewModel.currentStep,
                totalSteps: viewModel.onboardingItems.count,
                skipAction: viewModel.skip, nextAction: viewModel.nextStep
            )
        }
        .ignoresSafeArea()
    }
}


