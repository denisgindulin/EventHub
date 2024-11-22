//
//  LaunchCoordinator.swift
//  EventHub
//
//  Created by Руслан on 21.11.2024.
//

import Foundation
import UIKit

class LaunchCoordinator: Coordinator {
    
    fileprivate let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        perfomFlow()
    }
    
    func perfomFlow() {
        onboardingScreen()
    }
    
    func onboardingScreen() {
        let screen = ScreenFactory.makeOnboardingScreen(OnboardingActions(
            showSignIn: { [weak self] in self?.showSignInScreen() },
            showSignUp: { [weak self] in self?.showSignUpScreen() },
            closed: { [weak self] in self?.router.dismiss(animated: true) }))
        router.push(screen, animated: true)
    }
    
    func showSignInScreen() {
        let screen = ScreenFactory.makeSignInScreen(SignInActions(
            showMainScreen: { self.showMainScreen()},
            closed: { [weak self] in self?.router.dismiss(animated: true) }))
        router.present(screen, animated: true)
    }
    
    func showSignUpScreen() {
        let screen = ScreenFactory.makeSignUpScreen(SignUpActions(
            closed: { [weak self] in self?.router.dismiss(animated: true) }))
        router.present(screen, animated: true)
    }
    
    func showMainScreen() {
        let screen = ScreenFactory.makeMainView(TabBarActions(
            showEventsView: {
                
            },
            showFavoritesView: {
                
            },
            showMapView: {
                
            },
            showProfileView: {
                
            },
            showExploverView: {
                
            },
            close: {
                
            }))
        router.setRootModule(screen, hideBar: true)
    }
}
