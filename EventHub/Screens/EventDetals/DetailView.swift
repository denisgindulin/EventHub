//
//  DetailView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel: DetailViewModel
    
    @State private var isPresented: Bool = false
    
    // MARK: - Init
    init(detailID: Int) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(eventID: detailID))
    }
    
    var body: some View {
        ZStack {
            VStack {
                if let event = viewModel.event {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack {
                                ImageDetailView(imageUrl: viewModel.image)
                                DetailToolBar(isPresented: $isPresented, event: event)
                                    .padding(.vertical, 35)
                            }
                            
                            DetailInformationView(title: viewModel.title,
                                                  startDate: viewModel.startDate,
                                                  endDate: viewModel.endDate,
                                                  adress: viewModel.adress,
                                                  location: viewModel.location,
                                                  agentTitle: viewModel.agentTitle,
                                                  role: viewModel.role,
                                                  bodyText: viewModel.bodyText)
                        }
                    }
                    .ignoresSafeArea()
                } else {
                    ShimmerDetailView()
                }
            }
            
            // Затемненный фон и ShareView при isPresented == true
            if isPresented {
                // Полупрозрачный черный слой
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                
                ShareView(isPresented: $isPresented)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.3), value: isPresented)
        .task {
            await viewModel.fetchEventDetails()
        }
        .navigationBarHidden(true)
        .onAppear {
            appState.isDetailViewPresented = true
        }
        .onDisappear {
            appState.isDetailViewPresented = false
        }
    }
}

#Preview {
    DetailView(detailID: 32532)
}
