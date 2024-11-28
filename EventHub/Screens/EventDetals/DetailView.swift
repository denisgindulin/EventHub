//
//  DetailView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    
    @State private var isPresented: Bool = false
    
//    MARK: - Init
    init(detailID: Int) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(eventID: detailID)
        )
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 50) {
                    ZStack(alignment: .bottomTrailing) {
                        if let imageUrl = viewModel.image,
                           let url = URL(string: imageUrl) {
                            KFImage(url)
                                .placeholder {
                                    ShimmerView(ratio: 0.6)
                                        .scaledToFit()
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 244)
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 244)
                                .clipped()
                        } else {
                            Image(.cardImg1)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 244)
                                .clipped()
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
                                                title: viewModel.adress,
                                                description: viewModel.location)
                            
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
            }
//            .task {
//                await viewModel.fetchEventDetails()
//            }
            .ignoresSafeArea()
            
            if isPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
            }
            
            if isPresented {
                ShareView(isPresented: $isPresented)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    
}
