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
    
    // Инициализируем CoreDataManager
    @StateObject private var coreDataManager = CoreDataManager()
    @StateObject private var appState = AppState()
    
    init() {
        FirebaseApp.configure()
        DIContainer.register({ UDStorageService() as IStorageService}, forKey: .storageService, lifecycle: .singleton)
        DIContainer.register({ EventAPIService() as IAPIServiceForExplore & IAPIServiceForDetail }, forKey: .networkService, lifecycle: .singleton)
    }
    

    var body: some Scene {
        WindowGroup {
            StartRouterView()
                .environment(\.managedObjectContext, coreDataManager.viewContext)
                .environmentObject(coreDataManager)
                .environmentObject(appState)
        }
    }
}

class AppState: ObservableObject {
    @Published var isShareViewPresented: Bool = false
}
