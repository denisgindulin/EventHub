//
//  ImagePicker.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 02.12.2024.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator { image in
            self.image = image
        }
    }
    
    final class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let storageManager = StorageManager()
        
        var completion: ((UIImage) -> Void)
        
        init(completion: @escaping (UIImage) -> Void) {
            self.completion = completion
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                completion(image)

                if let imageData = image.pngData() {
                    print("PNG Image")
//                    storageManager.uploadImage(imageData: imageData)
                } else if let imageData = image.jpegData(compressionQuality: 0.1) {
                    print("JPEG Image")
//                    storageManager.uploadImage(imageData: imageData)
                }
            }
            picker.dismiss(animated: true)
        }
    }
}
