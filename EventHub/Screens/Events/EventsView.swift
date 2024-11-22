//
//  EventsView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var model: EventsViewModel
    var body: some View {
        Text("B")
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(EventsView.self)!
    }
}

