//
//  MainScreenFactory.swift
//  EventHub
//
//  Created by Руслан on 21.11.2024.
//

import Foundation
import UIKit
import SwiftUI
import Swinject

protocol MainScreenFactory {
    static func makeOnboardingScreen(_ actions: OnboardingActions) -> UIViewController
    static func makeSignInScreen(_ actions: SignInActions) -> UIViewController
    static func makeSignUpScreen(_ actions: SignUpActions) -> UIViewController
    static func makeTabBarView(_ actions: TabBarActions) -> UIViewController
    static func makeExploreScreen() -> UIViewController
    static func makeDetailScreen(eventID: Int, actions: DetailActions) -> UIViewController
    static func makeMapScreen() -> UIViewController
    static func makeProfileScreen() -> UIViewController
    static func makeEventsScreen() -> UIViewController
    static func makeFavoritesScreen() -> UIViewController
}

class ScreenFactory: MainScreenFactory {
    
    static func makeMapScreen() -> UIViewController {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(MapView.self)!
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    
    static func makeDetailScreen(eventID: Int, actions: DetailActions) -> UIViewController {
        let detailView = EventHubApp.dependencyProvider.assembler.resolver.resolve(DetailView.self, arguments: eventID, actions)!
        let vc = UIHostingController(rootView: detailView)
        return vc
    }
    
    static func makeProfileScreen() -> UIViewController {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(ProfileView.self)!
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    static func makeEventsScreen() -> UIViewController {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(EventsView.self)!
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    static func makeFavoritesScreen() -> UIViewController {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(BookmarksView.self)!
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    static func makeExploreScreen() -> UIViewController {
        let actions = EventHubApp.dependencyProvider.assembler.resolver.resolve(ExploreActions.self)!
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(ExploreView.self, argument: actions)!
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    static func makeOnboardingScreen(_ actions: OnboardingActions) -> UIViewController {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(OnboardingView.self, argument: actions)!
        let vc = UIHostingController(rootView: view)
        return vc
    }
    
    static func makeTabBarView(_ actions: TabBarActions) -> UIViewController {
        let router = NavigationRouter()
        let view = EventHubContentView(container: EventHubApp.dependencyProvider.assembler.resolver as! Container)
            .environmentObject(router)
        let vc = UIHostingController(rootView: view)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    static func makeSignInScreen(_ actions: SignInActions) -> UIViewController {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(SignInView.self, argument: actions)!
        let vc = UIHostingController(rootView: view)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
    static func makeSignUpScreen(_ actions: SignUpActions) -> UIViewController {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(SignUpView.self, argument: actions)!
        let vc = UIHostingController(rootView: view)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
}


extension ScreenFactory {
    static func makeExploverView() -> some View {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(ExploreView.self)!
        return view
    }
    
    static func makeFavoritesView() -> some View {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(BookmarksView.self)!
        return view
    }
    
    static func makeEventsView() -> some View {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(EventsView.self)!
        return view
    }
    
    static func makeProfileView() -> some View {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(ProfileView.self)!
        return view
    }
    
    static func makeMapView() -> some View {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(MapView.self)!
        return view
    }
    
    static func makeDetailView() -> some View {
        let view = EventHubApp.dependencyProvider.assembler.resolver.resolve(DetailView.self)!
        return view
    }
}
