//
//  EventsView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

// MARK: - EventsView
struct EventsView: View {
    @ObservedObject var model: EventsViewModel

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea(.all)
            VStack {
                ToolBarView(title: "Event")
                    .frame(height: 44)
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
                    .padding(.horizontal, 24)
                }
                
                BlueButtonWithArrow(text: "Explore Events") {
                    // Additional button logic
                }
                .padding(.horizontal, 53)
                .padding(.bottom, 50)
            }
            .task {
                await fetchUpcomingEventsWithErrorHandling()
            }
    
            .alert(isPresented: isPresentedAlert(for: $model.upcomingEventsPhase)) {
                Alert(
                    title: Text("Error"),
                    message: Text(model.errorMessage(for: model.upcomingEventsPhase)),
                    dismissButton: .default(Text("OK")) {
                        Task {
                            await model.fetchUpcomingEvents(ignoreCache: true)
                        }
                    }
                )
            }
        }
    }

   
    private func isPresentedAlert(for phase: Binding<DataFetchPhase<[EventModel]>>) -> Binding<Bool> {
        Binding(
            get: {
                if case .failure = phase.wrappedValue {
                    return true
                }
                return false
            },
            set: { isPresented in
                if !isPresented {
                    phase.wrappedValue = .empty
                }
            }
        )
    }
    
    private func loadEvents(for mode: EventsMode) async {
        switch mode {
        case .upcoming:
            await fetchUpcomingEventsWithErrorHandling()
        case .pastEvents:
            await model.fetchPastEvents()
        }
    }
    
    private func fetchUpcomingEventsWithErrorHandling() async {
        do {
            await model.fetchUpcomingEvents()
        } catch {
            model.upcomingEventsPhase = .failure(error)
        }
    }
}
#Preview {
    EventsView(model: EventsViewModel(actions: EventsActions(closed: {}), apiService: EventAPIService()))
}
