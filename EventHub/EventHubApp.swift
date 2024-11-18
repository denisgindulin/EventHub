//
//  EventHubApp.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI

@main
struct EventHubApp: App {
    var body: some Scene {
        
        WindowGroup {
            TabBarView(viewModel: TabBarViewModel())
        }
    }
}
