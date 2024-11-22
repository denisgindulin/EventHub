//
//  FavoritesView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var model: FavoritesViewModel
    
    var body: some View {
        Text("A")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(FavoritesView.self)!
    }
}
