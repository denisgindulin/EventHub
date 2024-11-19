//
//  OnboardingPageView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 19.11.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    let item: OnboardingItem
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image(item.image)
                .resizable()
                .scaledToFit()
            VStack(spacing: 32) {
                Text(item.title)
                    .airbnbCerealFont(.bold, size: 22)
                    .foregroundStyle(.white)
                Text(item.description)
                    .airbnbCerealFont(.book, size: 15)
                    .foregroundStyle(.white)
            }
            .padding(40)
            .frame(maxWidth: .infinity)
            .background(.appBlue)
            .cornerRadius(40, corners: [.topLeft, .topRight])
            .multilineTextAlignment(.center)
            
        }
        .ignoresSafeArea()
    }
}
