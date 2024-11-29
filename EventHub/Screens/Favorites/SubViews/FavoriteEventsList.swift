//
//  FavoriteEventsList.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 28.11.2024.
//

import SwiftUI

struct FavoriteEventsList: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(coreDataManager.events) { event in
                        NavigationLink {
                            DetailView(detailID: event.id)
                        } label: {
                            SmallEventCard(image: event.image ?? "cardImg1",
                                           date: event.date ?? .now,
                                           title: event.title?.capitalized ?? "No Title",
                                           place: event.adress ?? "No Adress",
                                           showBookmark: true) { coreDataManager.deleteEvent(event: event) }
                        }
                    }
                }
                .padding(24)
            }
        }
    }
}
