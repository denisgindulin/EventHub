//
//  SeeAllEventsView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 30.11.2024.
//

import SwiftUI

struct SeeAllEventsView: View {
    @Environment(\.dismiss) var dismiss
    let events: [ExploreModel]
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(events) { event in
                    NavigationLink {
                        DetailView(detailID: event.id)
                    } label: {
                        SmallEventCard(image: event.image ?? "No image/crach", date: event.date, title: event.title, place: event.adress)
                            .padding(.bottom,5)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("See All")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBarButtonView(foregroundStyle: .black)
            }
        }
        
    }
}

#Preview {
    SeeAllEventsView(events: [])
}
