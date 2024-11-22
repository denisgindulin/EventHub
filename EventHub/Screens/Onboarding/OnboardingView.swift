//
//  OnboardingView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var model: OnboardingViewModel
    var body: some View {
        
        
        Button(action: {
            model.showSignInView()
        }, label: {
            Text("Sign IN")
        })
        
        Button(action: {
            model.showSignUpView()
        }, label: {
            Text("Sign Up")
        })
        
        Button(action:
                {model.close()},
               label: {
            Text("Close")
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(OnboardingView.self)!
    }
}
