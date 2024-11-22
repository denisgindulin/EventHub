//
//  ExploreView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var model: ExploreViewModel
    var body: some View {
        Text("M")
    }
}


struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(ExploreView.self)!
    }
}
