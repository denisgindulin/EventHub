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
        if model.events.isEmpty {
            NoFavorites()
        } else {
            List {
                SmallEventCard(image: "cardImg1",
                               date: .now,
                               title: "Jo Malone London’s Mother’s Day Presents",
                               place: "Radius Gallery • Santa Cruz, CA",
                               showBookmark: true)
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    BookmarksView(model: BookmarksViewModel(actions: BookmarksViewActions()))
}
