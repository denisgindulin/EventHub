//
//  ScrollEventCardsView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct ScrollEventCardsView: View {

    let emptyArray: Bool
    let events: [ExploreModel]
    var showDetail: (Int) -> Void
    
    
    var body: some View {
        
//        if emptyArray {
//            
//            Text("No results")
//                .airbnbCerealFont(AirbnbCerealFont.book, size: 23)
//                .frame(width: 237, height: 255)
//            
//        } else {
           
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if events.isEmpty  {
                        ForEach(1..<6) { plug in
                            ShimmerView(ratio: 1)
                        }
                    } else {
//                        ForEach(1..<6) { plug in
//                            ShimmerView(ratio: 1)
//                        }
                        ForEach(events) { event in
                            EventCardView(event: event, showDetail: showDetail)
                                .padding(.vertical, 10)
                        }
                    }
                }
                .padding(.leading, 24)
            }
//        }
    }
}

#Preview {
    ScrollEventCardsView(emptyArray: true, events: [ExploreModel.example, ExploreModel.example], showDetail: {_ in } ) // or nil
}
