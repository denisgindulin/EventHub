//
//  MapView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var model: MapViewModel
    var body: some View {
        Text("H")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(MapView.self)!
    }
}
