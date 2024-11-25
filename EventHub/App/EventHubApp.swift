//
//  EventHubApp.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI

@main
struct EventHubApp: App {
    static let dependencyProvider = DependencyProvider()

    var body: some Scene {
        WindowGroup {
            RootViewControllerWrapper()
        }
    }
}

struct RootViewControllerWrapper: UIViewControllerRepresentable {
    @StateObject private var coordinatorHolder = CoordinatorHolder()

    func makeUIViewController(context: Context) -> UIViewController {
        let navigationController = UINavigationController()
        let router = Router(rootController: navigationController)
        let coordinator = LaunchCoordinator(router: router)
        coordinatorHolder.coordinator = coordinator
        coordinator.start()
        
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }

    private class CoordinatorHolder: ObservableObject {
        var coordinator: LaunchCoordinator?
    }
}
