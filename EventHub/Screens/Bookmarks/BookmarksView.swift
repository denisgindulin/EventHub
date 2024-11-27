//
//  BookmarksView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct BookmarksView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @ObservedObject var model: BookmarksViewModel
    
    init(model: BookmarksViewModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            if coreDataManager.events.isEmpty {
                NoFavorites()
            } else {
                List {
                    ForEach(coreDataManager.events) { event in
                        SmallEventCard(image: event.image ?? "cardImg1",
                                       date: event.date ?? .now,
                                       title: event.title?.capitalized ?? "No Title",
                                       place: event.adress ?? "No Adress",
                                       showBookmark: true)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
            }
        }
        .onAppear {
            coreDataManager.fetchEvents()
        }
    }
}

#Preview {
    BookmarksView(model: BookmarksViewModel(actions: BookmarksViewActions()))
}
