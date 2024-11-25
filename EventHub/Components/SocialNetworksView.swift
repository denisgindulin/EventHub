//
//  SocialNetworksView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 25.11.2024.
//

import SwiftUI

struct SocialNetworks: Identifiable {
    let id = UUID()
    let imageName: String
    let text: String
}

struct SocialNetworksView: View {
    let socialNetworks: [SocialNetworks] = [
        SocialNetworks(imageName: "CopyLink", text: "Copy Link"),
        SocialNetworks(imageName: "WhatsApp", text: "WhatsApp"),
        SocialNetworks(imageName: "Facebook", text: "Facebook"),
        SocialNetworks(imageName: "Messenger", text: "Messenger"),
        SocialNetworks(imageName: "Twitter", text: "Twitter"),
        SocialNetworks(imageName: "Instagram", text: "Instagram"),
        SocialNetworks(imageName: "Skype", text: "Skype"),
        SocialNetworks(imageName: "Message", text: "Message")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 23) {
            ForEach(socialNetworks) { socialNetwork in
                Button {
                    // Действие при нажатии на кнопку
                } label: {
                    VStack(spacing: 11) {
                        Image(socialNetwork.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 40)
                        Text(socialNetwork.text)
                            .font(.caption)
                            .airbnbCerealFont(.book, size: 13)
                            .foregroundStyle(Color(.label))
                    }
                }
            }
        }
    }
}
