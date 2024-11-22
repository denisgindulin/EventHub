//
//  ScrollEventCardsView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct ScrollEventCardsView: View {

    let events: [Event]?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let events = events {
                    ForEach(events) { event in
                        EventCardView(event: event)
                    }
                } else {
                    ForEach(1..<6) { plug in
                        ShimmerView(ratio: 1)
                    }
                }
            }
            .padding(.leading, 24)
        }
    }
}

#Preview {
    ScrollEventCardsView(events: [Event.example, Event.example] ) // or nil
}
