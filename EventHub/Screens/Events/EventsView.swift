//
//  EventsView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var model: EventsViewModel
    
    // MARK: - Drawing Constants
    private enum Drawing {
        static let toolbarHeight: CGFloat = 44
        static let horizontalSpacing: CGFloat = 24
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea(.all)
            VStack {
                ToolBarView(
                    title: "Event"
                )
                .frame(height: Drawing.toolbarHeight)
                .zIndex(1)
                
                ChangeModeButton(selectedMode: $model.selectedMode)
                    .onChange(of: model.selectedMode) { newValue in
                        Task {
                            await loadEvents(for: newValue)
                        }
                    }
                
                if model.eventsForCurrentMode().isEmpty {
                    EmptyEventsView(selectedMode: model.selectedMode)
                } else {
                    ScrollView(.vertical) {
                        ForEach(model.eventsForCurrentMode()) { event in
                            SmallEventCard(
                                image: event.image,
                                date: event.date,
                                title: event.title,
                                place: event.location
                            )
                        }
                    }
                    .padding(.horizontal, Drawing.horizontalSpacing)
                }
                
                BlueButtonWithArrow(text: "Explore Events") {
                }
                .padding(.horizontal, 53)
                .padding(.bottom, 50)
            }
            .task { await model.fetchUpcomingEvents() } 
        }
    }
    
    // MARK: - Methods
    private func loadEvents(for mode: EventsMode) async {
        switch mode {
        case .upcoming:
            await model.fetchUpcomingEvents()
        case .pastEvents:
            await model.fetchPastEvents()
        }
    }
}

#Preview {
    EventsView(model: EventsViewModel(apiService: EventAPIService(), actions: EventsActions(closed: {})))
}
