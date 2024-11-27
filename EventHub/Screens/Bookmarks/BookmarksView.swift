//
//  BookmarksView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct BookmarksView: View {
    
    @StateObject var viewModel: BookmarksViewModel
    
    
    init() {
        self._viewModel = StateObject(wrappedValue: BookmarksViewModel()
        )
    }
    
    var body: some View {
        if viewModel.events.isEmpty {
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

}
