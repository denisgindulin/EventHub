//
//  EventHubApp.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI
import FirebaseCore

@main
struct EventHubApp: App {
    static let dependencyProvider = DependencyProvider()
    
    init(){
        FirebaseApp.configure()
    }
    

    var body: some Scene {
        WindowGroup {
            RootViewControllerWrapper(dependencyProvider: EventHubApp.dependencyProvider)
        }
    }
}

struct RootViewControllerWrapper: UIViewControllerRepresentable {
    private let dependencyProvider: DependencyProvider
    @StateObject private var coordinatorHolder = CoordinatorHolder()

    
    init(dependencyProvider: DependencyProvider) {
        self.dependencyProvider = dependencyProvider
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let navigationController = dependencyProvider.container.resolve(UINavigationController.self)!
        let coordinator = dependencyProvider.container.resolve(LaunchCoordinator.self)!
        coordinatorHolder.coordinator = coordinator
        coordinator.start()
        navigationController.navigationBar.isHidden = true
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }

    private class CoordinatorHolder: ObservableObject {
        var coordinator: LaunchCoordinator?
    }
}




