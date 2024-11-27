//
//  BookmarksView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct BookmarksView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject var viewModel: BookmarksViewModel
    
    
    init() {
        self._viewModel = StateObject(wrappedValue: BookmarksViewModel()
        )
    }
    
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
                                       showBookmark: true) { coreDataManager.deleteEvent(event: event) }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.inset)
            }
        }
        .onAppear {
            coreDataManager.fetchEvents()
        }
    }
    
    func deleteEvent(offsets: IndexSet) {
        offsets.map { coreDataManager.events[$0] }.forEach { event in
            coreDataManager.deleteEvent(event: event)
        }
    }
}

#Preview {

}
