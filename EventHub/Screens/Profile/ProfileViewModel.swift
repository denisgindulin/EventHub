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
    let currentUser = Auth.auth().currentUser
    private let firestoreManager = FirestoreManager()
    
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
    
    func updateUserProfile(name: String, info: String, image: String) {
        guard let currentUser = currentUser else { return }
        
            let userId = currentUser.uid
            let updatedData: [String: Any] = [
                "name": name,
                "image": image,
                "info": info
            ]
            
            firestoreManager.updateUserData(userId: userId, data: updatedData)
        }
    
    func openApp() {
        router.updateRouterState(with: .userLoggedOut)
    }
    
}
