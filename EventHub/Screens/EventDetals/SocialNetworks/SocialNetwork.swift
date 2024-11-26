//
//  SocialNetwork.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 26.11.2024.
//

import Foundation

struct SocialNetwork: Identifiable {
    let id = UUID()
    let imageName: String
    let text: String
    let appId: String?
}
