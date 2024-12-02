//
//  FirebaseManager.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 02.12.2024.
//

import Foundation
import FirebaseAuth
import FirebaseAuthCombineSwift

final class FirebaseManager: ObservableObject {
    @Published var user: UserData?
    
    private let firestoreManager = FirestoreManager()
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        listenToAuthState()
    }
    
    func listenToAuthState() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener  { [weak self] auth, user in
                if let user {
                    print(user.uid)
                    self?.loadUserData(userId: user.uid)
                } else {
                    self?.user = nil
                }
            }
        }
    }
    
    func loadUserData(userId: String) {
        Task {
            guard let user = try? await firestoreManager.getUserData(userId: userId) else { return }
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
}
