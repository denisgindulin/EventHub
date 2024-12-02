//
//  SeeAllEventsView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 30.11.2024.
//

import SwiftUI

enum EventType {
    case movie
    case list
    case regular
}

struct SeeAllEventsView: View {
    @Environment(\.dismiss) var dismiss
    let events: [ExploreModel]
    var eventType: EventType = .regular

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(events) { event in
                    eventView(for: event)
                        .padding(.bottom, 5)
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
    

    func eventView(for event: ExploreModel) -> some View {
        switch eventType {
        case .list:
            return AnyView(ThirdSmallEventCard(
                title: event.title,
                link: event.adress
            ))
        case .movie:
            return AnyView(SmallEventCardForMovie(
                image: event.image ?? "No image",
                title: event.title,
                url: event.adress
            ))
        case .regular:
            return AnyView(SmallEventCard(
                image: event.image ?? "No image/crach",
                date: event.date,
                title: event.title,
                place: event.adress
            ))
        }
    }
}

#Preview {
    SeeAllEventsView(events: [])
}
