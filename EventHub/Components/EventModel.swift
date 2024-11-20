//
//  EventModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import Foundation

struct Event: Identifiable {
    let id = UUID() // random id если нет в апи
    let title: String
    let visitors: [Visitor]?
    let date: String
    let adress: String
    let image: String? // url/data ?
    let isFavorite: Bool
    
    static let example = Event(  title: "Internationl Band Muzzzzz",
                                 visitors: [Visitor(image: "visitor", name: "Sonya"),
                                            Visitor(image: "visitor", name: "Sonya"),
//                                            Visitor(image: "visitor", name: "Sonya"),
                                            Visitor(image: "visitor", name: "Sonya"),
                                            Visitor(image: "visitor", name: "Sonya"),
                                            Visitor(image: "visitor", name: "Sonya")],
                                 date: "10 JUN",
                                 adress: "36 Guild Street London, UK",
                                 image: "cardImg1", isFavorite: true )
}

struct Visitor: Identifiable {
    let id = UUID()
    let image: String
    let name: String
}
