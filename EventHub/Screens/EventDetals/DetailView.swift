//
//  DetailView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject private var viewModel: DetailViewModel
    
    @State private var isPresented: Bool = false
    
    //    MARK: - Init
    init(detailID: Int) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(eventID: detailID))
    }
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack {
                            ImageDetailView(imageUrl: viewModel.image)
                            DetailToolBar(isPresented: $isPresented, event: viewModel.event)
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
            }
            
            if isPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
            }
            
            if isPresented {
                ShareView(isPresented: $isPresented)
            }
        }
        .task {
            await viewModel.fetchEventDetails()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DetailView(detailID: 32532)
}
