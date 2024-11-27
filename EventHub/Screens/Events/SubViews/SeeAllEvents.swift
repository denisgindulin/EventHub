//
//  SeeAllEvents.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 25.11.2024.
//

import SwiftUI

struct SeeAllEvents: View {
// @ObservedObject var model: EventsViewModel
    
    var body: some View {
        ZStack {
            VStack {
                ToolBarView(
                    title: "Event",
                    isTitleLeading: true,
                    showBackButton: true,
                    backButtonAction: {},
                    actions: [ToolBarAction(
                        icon: ToolBarButtonType.search.icon,
                        action: {},
                        hasBackground: false,
                        foregroundStyle: Color.black)
                    ]
                )
            
        }
        ScrollView {
            
        }
    }
    }
}

#Preview {
    SeeAllEvents()
}

