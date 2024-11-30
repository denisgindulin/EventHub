//
//  ProfileViewModel.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import Foundation
import FirebaseAuth

final class ProfileViewModel: ObservableObject {

    private let router: StartRouter
    
    //MARK: - Firebase
    
    @Published var name: String = "Ashfak Sayem" // Save redacted in firestore DidSet
    
    @Published var info: String = "Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read MoreEnjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More "
        
    @Published var image: String = ""
    
    
    
    
    init(router: StartRouter) {
        self.router = router
    }
    
    
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            openApp()
        } catch {
            print("error SIGN OUT")
        }
    }
    
    func openApp() {
        router.updateRouterState(with: .userLoggedOut)
    }
    
}
