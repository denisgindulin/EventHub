//
//  FirebaseManager.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 02.12.2024.
//

import Foundation
import FirebaseAuth


final class FirebaseManager: ObservableObject {
    @Published var user: UserData?
    
    @Published var name: String = ""
    @Published var info: String = ""
    @Published var userAvatar: String?
    
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
                    self?.loadAvatar(userId: user.uid)
                } else {
                    self?.user = nil
                }
            }
        }
    }
    
    func loadUserData(userId: String) {
        Task {
            guard let user = try? await firestoreManager.getUserData(userId: userId) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.user = user
                self?.name = user.name
                self?.info = user.info
            }
        }
    }
    
    func loadAvatar(userId: String) {
        firestoreManager.loadAvatarUrl(userId: userId)
        firestoreManager.$avatarUrl
            .receive(on: DispatchQueue.main)
            .assign(to: &$userAvatar)
    }
}
