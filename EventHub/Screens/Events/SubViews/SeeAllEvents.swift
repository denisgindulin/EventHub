//
//  SeeAllEvents.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 25.11.2024.
//

import SwiftUI

struct SeeAllEvents: View {
    
    // MARK: - Properties
    @State private var showSearchFlow = false
    
    let allEvents: [EventModel] 
    
    // MARK: - Body
    var body: some View {
            ZStack {
                
                // MARK: - Content Layout
                VStack(spacing: 0) {
                    
                    // MARK: - Toolbar
                    ToolBarView(
                        title: "Event".localized,
                        isTitleLeading: true,
                        showBackButton: true,
                        actions: [ToolBarAction(
                            icon: ToolBarButtonType.search.icon,
                            action: { showSearchFlow = true },
                            hasBackground: false,
                            foregroundStyle: Color.black)
                        ]
                    )
                    .zIndex(1)
                    .padding(.top, 0)
                    Spacer()
                    
                    // MARK: - Event List
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(allEvents) { event in
                            NavigationLink(destination: DetailView(detailID: event.id)) {  // Navigate to event detail
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
                    .overlay(
                        NavigationLink(
                            destination: SearchView(
                                searchScreenType: .withData,
                                localData: allEvents.map { ExploreModel(event: $0) }
                            ),
                            isActive: $showSearchFlow,
                            label: { EmptyView() }
                        )
                    )
                }
            }
            .navigationBarHidden(true)
        
    }
}

#Preview {
    SeeAllEvents(allEvents: [])
}
