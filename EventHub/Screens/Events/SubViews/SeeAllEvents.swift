//
//  SeeAllEvents.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 25.11.2024.
//

import SwiftUI

struct SeeAllEvents: View {
    // @ObservedObject var model: EventsViewModel
    let allEvents: [EventModel]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ToolBarView(
                    title: "Event",
                    isTitleLeading: true,
                    showBackButton: true,
                    actions: [ToolBarAction(
                        icon: ToolBarButtonType.search.icon,
                        action: {},
                        hasBackground: false,
                        foregroundStyle: Color.black)
                    ]
                )
                .zIndex(1)
                .padding(.top, 0)
                Spacer()
           
            ScrollView {
                ForEach(allEvents) { event in
                    NavigationLink(destination: DetailView(detailID: event.id)) {
                        SmallEventCard(
                            image: event.image,
                            date: event.date,
                            title: event.title,
                            place: event.location
                        )
                    }
                    
                    
                    .padding(.horizontal, 24)
                    
                }
            }
        }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SeeAllEvents(allEvents: [])
}

