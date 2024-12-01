//
//  ScrollEventCardsView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct ScrollEventCardsView: View {

    let events: [ExploreModel]?
    var showDetail: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let events = events {
                    ForEach(events) { event in
                        EventCardView(event: event, showDetail: showDetail)
                            .padding(.vertical, 10)
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
    ScrollEventCardsView(events: [ExploreModel.example, ExploreModel.example], showDetail: {_ in } ) // or nil
}
