//
//  FirestoreManager.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 02.12.2024.
//

import Foundation
import FirebaseFirestore

struct UserData: Identifiable {
    let id: String
    let name: String
    let email: String
    let info: String
}

final class FirestoreManager: ObservableObject {
    func saveUserData(userId: String, name: String, email: String) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData([
                "name": name,
                "email": email,
                "info": ""
            ])
    }
    
    func getUserData(userId: String) async throws -> UserData {
        let document = try await Firestore.firestore()
            .collection("users")
            .document(userId)
            .getDocument()
        
        guard let data = document.data() else {
            throw FirestoreError.documentNotFound
        }
        
        guard let name = data["name"] as? String else {
            throw FirestoreError.fieldNotFound(fieldName: "name")
        }
        
        guard let email = data["email"] as? String else {
            throw FirestoreError.fieldNotFound(fieldName: "email")
        }
        
        guard let info = data["info"] as? String else {
            throw FirestoreError.fieldNotFound(fieldName: "info")
        }
        
        return UserData(id: userId,
                        name: name,
                        email: email,
                        info: info)
    }
    
    func updateUserData(userId: String, data: [String: Any]) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .updateData(data) { error in
            if let error = error {
                print("Ошибка обновления данных: \(error.localizedDescription)")
            } else {
                print("Данные пользователя обновлены")
            }
        }
    }
}
