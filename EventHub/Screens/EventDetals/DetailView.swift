//
//  DetailView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel = DetailViewModel()
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: viewModel.imageUrl) { image in
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
                    Text(viewModel.title)
                        .airbnbCerealFont(.book, size: 35)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        DetailComponentView(image: Image(systemName: "calendar"),
                                            title: viewModel.startDate,
                                            description: viewModel.endDate)
                        
                        DetailComponentView(image: Image(.location),
                                            title: "viewModel.place",
                                            description: viewModel.adress)
                        
                        DetailComponentView(image: Image(.cardImg2),
                                            title: viewModel.agentTitle,
                                            description: viewModel.role,
                                            showImgBg: false)
                    }
                    
                    Text("About Event")
                        .airbnbCerealFont(.medium, size: 18)
                    Text(viewModel.bodyText)
                        .airbnbCerealFont(.book)
                }
                .padding(.horizontal, 20)
            }
            .sheet(isPresented: $isPresented) {
                ActivityViewController(text: viewModel.title)
            }
        }
        .task {
            await viewModel.fetchEventDetails(eventID: 168359)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DetailView()
}
