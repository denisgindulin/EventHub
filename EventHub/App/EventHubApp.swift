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
    
    init(){
        FirebaseApp.configure()
    }
    

    var body: some Scene {
        WindowGroup {
            StartRouterView()
        }
    }
}


