//
//  EventMarker.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 30.11.2024.
//

import SwiftUI

struct EventMarker: View {
    let event: MapEventModel

    var body: some View {
        VStack {
            Image(event.image)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)

        }
    }
}
