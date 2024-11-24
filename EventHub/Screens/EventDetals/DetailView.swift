//
//  DetailView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var model: DetailViewModel
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                ZStack(alignment: .bottomTrailing) {
                    ToolBarView(
                        title: "Event Details",
                        isTitleLeading: true,
                        showBackButton: true,
                        backButtonAction: model.close,
                        actions: [ToolBarAction(
                            icon: ToolBarButtonType.bookmark.icon,
                            action: model.changeBookmark,
                            hasBackground: true,
                            foregroundStyle: Color.white)
                        ]
                    )
                    AsyncImage(url: model.imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 244)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Button {
                        isPresented = true
                    } label: {
                        Image(.share)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 24, maxHeight: 24)
                            .padding(6)
                            .background(.white.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(14)
                    }

                }
                
                VStack(alignment: .leading, spacing: 24) {
                    Text(model.title)
                        .airbnbCerealFont(.book, size: 35)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        DetailComponentView(image: Image(systemName: "calendar"),
                                            title: model.startDate,
                                            description: model.endDate)
                        
                        DetailComponentView(image: Image(.location),
                                            title: "viewModel.place",
                                            description: model.adress)
                        
                        DetailComponentView(image: Image(.cardImg2),
                                            title: model.agentTitle,
                                            description: model.role,
                                            showImgBg: false)
                    }
                    
                    Text("About Event")
                        .airbnbCerealFont(.medium, size: 18)
                    Text(model.bodyText)
                        .airbnbCerealFont(.book)
                }
                .padding(.horizontal, 20)
            }
            .sheet(isPresented: $isPresented) {
                ActivityViewController(text: model.title)
            }
        }
        .task {
            await model.fetchEventDetails()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DetailView(model: DetailViewModel(eventID: 188742, actions: DetailActions(closed: {}), eventService: EventAPIService()))
}
