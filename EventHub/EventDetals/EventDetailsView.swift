//
//  EventDetailsView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import SwiftUI

struct EventDetailsView: View {
    @StateObject var viewModel = EventDetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                ZStack {
                    AsyncImage(url: viewModel.imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 244)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("International Band Music Concert")
                        .airbnbCerealFont(.book, size: 35)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        DetailComponentView(image: "lock", title: viewModel.date.formattedDate2(), description: viewModel.time)
                        
                        DetailComponentView(image: "location", title: viewModel.place, description: viewModel.adress)
                        
                        DetailComponentView(image: "cardImg1", title: viewModel.person, description: viewModel.personRole, showImgBg: false)
                    }
                    
                    Text("About Event")
                        .airbnbCerealFont(.medium, size: 18)
                    Text(viewModel.aboutEvent)
                        .airbnbCerealFont(.book)
                }
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EventDetailsView()
}
