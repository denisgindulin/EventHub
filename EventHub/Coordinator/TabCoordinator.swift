//
//  TabCoordinator.swift
//  EventHub
//
//  Created by Руслан on 21.11.2024.
//


import SwiftUI
import Swinject

class TabCoordinator {
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func view(for tab: Tab) -> AnyView {
        switch tab {
        case .explore:
            return AnyView(ViewControllerWrapper(viewController: ScreenFactory.makeExploverScreen()))
        case .events:
            return AnyView(ViewControllerWrapper(viewController: ScreenFactory.makeEventsScreen()))
        case .bookmark:
            return AnyView(ViewControllerWrapper(viewController: ScreenFactory.makeFavoritesScreen()))
        case .map:
            return AnyView(ViewControllerWrapper(viewController: ScreenFactory.makeMapScreen()))
        case .profile:
            return AnyView(ViewControllerWrapper(viewController: ScreenFactory.makeProfileScreen()))
        }
    }
}

struct ViewControllerWrapper: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Do nothing
    }
}
