//
//  Router.swift
//  EventHub
//
//  Created by Руслан on 21.11.2024.
//

import Foundation
import UIKit

enum Tab: String, CaseIterable {
    case explore
    case events
    case bookmark
    case map
    case profile
    
    var title: String {
        switch self {
        case .explore:
            return "Explore"
        case .events:
            return "Events"
        case .map:
            return "Map"
        case .profile:
            return "Profile"
        case .bookmark:
            return ""
        }
    }
    
    var icon: String {
        switch self {
        case .explore:
            return "explore"
        case .events:
            return "events"
        case .map:
            return "map"
        case .profile:
            return "profileTab"
        case .bookmark:
            return "bookmark"
        }
    }
}

class NavigationRouter: ObservableObject {
    @Published var selectedTab: Tab = .explore
    
    func switchTab(_ tab: Tab) {
        selectedTab = tab
    }
}

typealias CompletionBlock = () -> Void

protocol Routed {
    func push(_ viewController: UIViewController, animated: Bool)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
}

class Router: Routed {
    private let rootController: UINavigationController

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func dismiss(animated: Bool) {
        if rootController.presentedViewController != nil {
            rootController.dismiss(animated: animated)
        } else {
            print("Нет ViewController")
        }
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController.isNavigationBarHidden = true
        rootController.setViewControllers([controller], animated: false)
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func pop(animated: Bool) {
        rootController.popViewController(animated: animated)
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        rootController.pushViewController(viewController, animated: animated)
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController.present(controller, animated: animated)
    }
}

protocol Presentable {
    var toPresent: UIViewController? { get }
}

extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}
