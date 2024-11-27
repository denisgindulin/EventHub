//
//  EventsView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

// MARK: - EventsView
struct EventsView: View {

    @StateObject var viewModel: EventsViewModel
    
    
    init(eventAPIService: IEventAPIServiceForEvents) {
        self._viewModel = StateObject(wrappedValue: EventsViewModel(apiService: eventAPIService)
        )
    }
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea(.all)
            VStack {
                ToolBarView(title: "Event")
                    .frame(height: 44)
                    .zIndex(1)
                
                ChangeModeButton(selectedMode: $viewModel.selectedMode)
                    .onChange(of: viewModel.selectedMode) { newValue in
                        Task {
                            await loadEvents(for: newValue)
                        }
                    }
                
                if viewModel.eventsForCurrentMode().isEmpty {
                    EmptyEventsView(selectedMode: viewModel.selectedMode)
                } else {
                    ScrollView(.vertical) {
                        ForEach(viewModel.eventsForCurrentMode()) { event in
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
                await viewModel.fetchUpcomingEvents()
            }
    
            .alert(isPresented: isPresentedAlert(for: $viewModel.upcomingEventsPhase)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage(for: viewModel.upcomingEventsPhase)),
                    dismissButton: .default(Text("OK")) {
                        Task {
                            await viewModel.fetchUpcomingEvents(ignoreCache: true)
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
            await viewModel.fetchUpcomingEvents()
        case .pastEvents:
            await viewModel.fetchPastEvents()
        }
    }
}
#Preview {

}
