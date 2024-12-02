//
//  StorageManager.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 02.12.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class StorageManager {
    func uploadImage(imageData: Data) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let storageRef = Storage.storage().reference().child("avatars/\(userId)/avatar.jpg")
        
        Task {
            do {
                let url = try await uploadOneImage(image: imageData, storageLink: storageRef)
                saveAvatarUrl(stringUrl: url.absoluteString)
                print(url.absoluteString)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveAvatarUrl(stringUrl: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(["avatarUrl": stringUrl], merge: true)
    }
    
    func uploadOneImage(image: Data?, storageLink: StorageReference) async throws -> URL {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        guard let imageData = image else {
            throw NSError(domain: "ImageDataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Image data is nil"])
        }
        
        _ = try await storageLink.putDataAsync(imageData, metadata: metaData)
        
        let url = try await storageLink.downloadURL()
        return url
    }
}
