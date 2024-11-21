//
//  ActivityView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
    // Данные, которыми будем делиться
    let text: String
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil

    // Создание `UIActivityViewController`
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
