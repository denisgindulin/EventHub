//
//  MainViewModel.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
    let currentPosition: String = "New York, USA"
    
    let categories: [String] = ["Sports", "Music", "Food", "More"]
    let categoryColors: [Color] = [.appRed, .appOrange, .appGreen, .appCyan]
    let categoryPictures: [String] = ["ball", "music","eat", "profile"] // paint image = person ???
}
