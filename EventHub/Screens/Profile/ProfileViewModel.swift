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
    private let firestoreManager = FirestoreManager()
    private let firebaseManager = FirebaseManager()
    
    //MARK: - Firebase
    @Published var name: String = ""
    @Published var info: String = ""
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
    
    func updateUserName() {
        
    }
    func updateUserProfile() {
            guard let currentUser = Auth.auth().currentUser else { return }
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
