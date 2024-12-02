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
    @State private var showAllEvents = false
    
    //    MARK: - INIT
    init() {
        self._viewModel = StateObject(wrappedValue: EventsViewModel()
        )
    }
    
    //    MARK: - BODY
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea(.all)
            VStack {
                ToolBarView(title: "Event".localized)
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
                        ForEach(viewModel.eventsForCurrentMode()) { event in NavigationLink(destination: DetailView(detailID: event.id)) {
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
                }
                
                BlueButtonWithArrow(text: "Explore Events".localized) {
                    Task {
                        await viewModel.updateAllEvents()
                    }
                    showAllEvents = true
                }
                .padding(.horizontal, 53)
                .padding(.bottom, 40)
                .background(
                    NavigationLink(
                        destination: SeeAllEvents(allEvents: viewModel.allEvents),
                        isActive: $showAllEvents,
                        label: { EmptyView() }
                    )
                )
            }
            .navigationBarHidden(true)
            .task {
                await viewModel.fetchUpcomingEvents()
            }
            
            .alert(isPresented: isPresentedAlert(for: $viewModel.upcomingEventsPhase)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage(for: viewModel.upcomingEventsPhase)),
                    dismissButton: .default(Text("OK")) {
                        Task {
                            await loadEvents(for: viewModel.selectedMode)
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
    EventsView()
}
