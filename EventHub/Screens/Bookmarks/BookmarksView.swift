//
//  BookmarksView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct BookmarksView: View {
    @ObservedObject var model: BookmarksViewModel
    
    var body: some View {
        Text("A")
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(BookmarksView.self)!
    }
}
