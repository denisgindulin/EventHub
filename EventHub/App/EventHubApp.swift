//
//  EventHubApp.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct EventHubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var coreDataManager = CoreDataManager()
    @StateObject private var firebaseManager = FirebaseManager()
    @StateObject private var appState = AppState()
    
    init() {
        DIContainer.register({ UDStorageService() as IStorageService}, forKey: .storageService, lifecycle: .singleton)
        DIContainer.register({ EventAPIService() as IAPIServiceForExplore & IAPIServiceForDetail }, forKey: .networkService, lifecycle: .singleton)
    }
    

    var body: some Scene {
        WindowGroup {
            StartRouterView()
                .environment(\.managedObjectContext, coreDataManager.viewContext)
                .environmentObject(coreDataManager)
                .environmentObject(firebaseManager)
                .environmentObject(appState)
        }
    }
}
