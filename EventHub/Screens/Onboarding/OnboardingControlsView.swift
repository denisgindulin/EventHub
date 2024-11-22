//
//  OnboardingControlsView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 19.11.2024.
//

import SwiftUI

struct OnboardingControlsView: View {
    @Binding var currentStep: Int
    let totalSteps: Int
    let skipAction: () -> Void
    let nextAction: () -> Void
    
    var body: some View {
        HStack {
            Button("Skip") {
                skipAction()
            }
            .airbnbCerealFont(.medium, size: 18)
            .foregroundColor(.white)
            .opacity(0.4)
            
            Spacer()
            
            HStack {
                ForEach(0..<totalSteps, id: \.self) { index in
                    if index == currentStep {
                        Rectangle()
                            .frame(width: 20, height: 10)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.white)
                            .opacity(0.4)
                    }
                }
            }
            
            Spacer()
            
            Button(currentStep < totalSteps - 1 ? "Next" : "Start") {
                withAnimation {
                    nextAction()
                }
            }
            .airbnbCerealFont(.medium, size: 18)
            .foregroundColor(.white)
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 20)
        .background(.appBlue)
    }
}
