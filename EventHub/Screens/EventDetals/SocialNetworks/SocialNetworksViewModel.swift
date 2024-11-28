//
//  SocialNetworksViewModel.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 26.11.2024.
//

import SwiftUI

final class SocialNetworksViewModel: ObservableObject {
    let socialNetworks: [SocialNetwork] = [
        SocialNetwork(imageName: "copyLink", text: "Copy Link", appId: nil, urlScheme: nil),
        SocialNetwork(imageName: "whatsapp", text: "WhatsApp", appId: "310633997", urlScheme: "whatsapp"),
        SocialNetwork(imageName: "fb", text: "Facebook", appId: "284882215", urlScheme: "fb"),
        SocialNetwork(imageName: "messenger", text: "Messenger", appId: "454638411", urlScheme: "messenger"),
        SocialNetwork(imageName: "twitter", text: "Twitter", appId: "333903271", urlScheme: "twitter"),
        SocialNetwork(imageName: "instagram", text: "Instagram", appId: "389801252", urlScheme: "instagram"),
        SocialNetwork(imageName: "tg", text: "Telegram", appId: "686449807", urlScheme: "tg"),
        SocialNetwork(imageName: "sms", text: "Message", appId: nil, urlScheme: nil)
    ]

    func share(in socialNetwork: SocialNetwork) {
        if let urlScheme = socialNetwork.urlScheme,
           let appURL = URL(string: "\(urlScheme)://") {
            
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                
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
