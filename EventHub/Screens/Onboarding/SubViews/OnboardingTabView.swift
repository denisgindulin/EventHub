//
//  OnboardingTabView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 19.11.2024.
//

import SwiftUI

struct OnboardingTabView: View {
    @Binding var currentStep: Int
    let onboardingItems: [OnboardingItem]
    
    var body: some View {
        TabView(selection: $currentStep) {
            ForEach(0..<onboardingItems.count, id: \.self) { item in
                OnboardingPageView(item: onboardingItems[item])
                    .tag(item)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
