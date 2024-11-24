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
            showTabbar: {[weak self] in self?.showMainScreen()},
            closed: { [weak self] in self?.router.dismiss(animated: true) }))
        router.push(screen, animated: true)
    }
    
    func showSignInScreen() {
        let screen = ScreenFactory.makeSignInScreen(SignInActions(
            showMainScreen: { [weak self] in self?.showMainScreen()},
            closed: { [weak self] in self?.router.dismiss(animated: true) }))
        router.present(screen, animated: true)
    }
    
    func showSignUpScreen() {
        let screen = ScreenFactory.makeSignUpScreen(SignUpActions(
            closed: { [weak self] in self?.router.dismiss(animated: true) }))
        router.present(screen, animated: true)
    }
    
    
    func showMainScreen() {
        let screen = ScreenFactory.makeTabBarView(TabBarActions(
            showEventsView: {
                
            },
            showFavoritesView: {
                
            },
            showMapView: {
                
            },
            showProfileView: {
                
            },
            showExploreView: {
                
            },
            close: {
                
            }))
        router.setRootModule(screen, hideBar: true)
    }
    
//    func showExploreScreen() {
//        let screen = ScreenFactory.makeExploreScreen(ExploreActions(
//            showDetail: { [weak self] eventID in
//                self?.showEventDetail(eventID: eventID)
//            },
//            closed: { [weak self] in
//                self?.router.dismiss(animated: true)
//            }
//        ))
//        router.push(screen, animated: true)
//    }
    
    func showEventDetail(eventID: Int) {
        let actions = DetailActions(closed: { [weak self] in
            self?.router.dismiss(animated: true)
        })
        
        let screen = ScreenFactory.makeDetailScreen(
            eventID: eventID,
            actions: actions
        )
        router.present(screen, animated: true)
    }
}
