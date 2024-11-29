//
//  ProfileViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {

    private let router: StartRouter
    
    init(router: StartRouter) {
        self.router = router
    }
    
    
    func openApp() {
        router.updateRouterState(with: .userLoggedOut)
    }
    
}
