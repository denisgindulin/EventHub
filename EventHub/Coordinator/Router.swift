//
//  Router.swift
//  EventHub
//
//  Created by Руслан on 21.11.2024.
//

import Foundation
import UIKit

// MARK: - Tab Enum
enum Tab: String, CaseIterable {
    case explore
    case events
    case bookmark
    case map
    case profile
    
    // MARK: - Title for Tabs
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
            return "" // Bookmark doesn't have a title
        }
    }
    
    // MARK: - Icon for Tabs
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

// MARK: - NavigationRouter Class
class NavigationRouter: ObservableObject {
    @Published var selectedTab: Tab = .explore
    
    // MARK: - Switch Between Tabs
    func switchTab(_ tab: Tab) {
        selectedTab = tab
    }
}

// MARK: - Completion Block Type Alias
typealias CompletionBlock = () -> Void

// MARK: - Routed Protocol (Interface for Navigation Actions)
protocol Routed {
    func push(_ viewController: UIViewController, animated: Bool)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
}

// MARK: - Router Class Implementation (Handles navigation actions)
class Router: Routed {
    private let rootController: UINavigationController

    // MARK: - Initializer
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    // MARK: - Dismiss ViewController
    func dismiss(animated: Bool) {
        if rootController.presentedViewController != nil {
            rootController.dismiss(animated: animated)
        } else {
            print("No ViewController to dismiss")
        }
    }
    
    // MARK: - Set Root Module
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController.isNavigationBarHidden = true
        rootController.setViewControllers([controller], animated: false)
    }
    
    // MARK: - Present Module
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    // MARK: - Pop ViewController
    func pop(animated: Bool) {
        rootController.popViewController(animated: animated)
    }

    // MARK: - Push ViewController
    func push(_ viewController: UIViewController, animated: Bool) {
        rootController.pushViewController(viewController, animated: animated)
    }

    // MARK: - Present Module with Animation Option
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController.present(controller, animated: animated)
    }
}

// MARK: - Presentable Protocol (Interface for Presentable Modules)
protocol Presentable {
    var toPresent: UIViewController? { get }
}

// MARK: - UIViewController Extension (Makes it conform to Presentable)
extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}
