//
//  EventHubApp.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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




