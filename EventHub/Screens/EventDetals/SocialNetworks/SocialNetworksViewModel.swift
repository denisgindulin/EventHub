//
//  SocialNetworksViewModel.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 26.11.2024.
//

import SwiftUI

final class SocialNetworksViewModel: ObservableObject {
    let socialNetworks: [SocialNetwork] = [
        SocialNetwork(imageName: "copyLink", text: "Copy Link", appId: nil),
        SocialNetwork(imageName: "whatsapp", text: "WhatsApp", appId: "310633997"),
        SocialNetwork(imageName: "fb", text: "Facebook", appId: "284882215"),
        SocialNetwork(imageName: "messenger", text: "Messenger", appId: "454638411"),
        SocialNetwork(imageName: "twitter", text: "Twitter", appId: "333903271"),
        SocialNetwork(imageName: "instagram", text: "Instagram", appId: "389801252"),
        SocialNetwork(imageName: "tg", text: "Telegram", appId: "686449807"),
        SocialNetwork(imageName: "sms", text: "Message", appId: nil)
    ]

    func share(in socialNetwork: SocialNetwork) {
        if let appURL = URL(string: "\(socialNetwork.imageName)://") {
            if UIApplication.shared.canOpenURL(appURL) {
                if socialNetwork.imageName != "copyLink" {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } 
            } else {
                // Приложение не установлен, открываем страницу приложения в App Store
                if let appId = socialNetwork.appId,
                   let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
