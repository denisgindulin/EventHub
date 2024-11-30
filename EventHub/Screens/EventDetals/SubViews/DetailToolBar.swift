//
//  DetailToolBar.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 30.11.2024.
//

import SwiftUI

struct DetailToolBar: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @Binding var isPresented: Bool
    let event: EventDTO
    
    private var isFavorite: Bool {
        coreDataManager.events.contains { event in
            Int(event.id) == self.event.id
        }
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            ToolBarView(
                title: "Event Details",
                foregroundStyle: .white,
                isTitleLeading: true,
                showBackButton: true,
                actions: [
                    ToolBarAction(
                        icon: isFavorite ? ToolBarButtonType.bookmarkFill.icon : ToolBarButtonType.bookmark.icon,
                        action: {
                            if !isFavorite {
                                coreDataManager.createEvent(event: event)
                            } else {
                                coreDataManager.deleteEvent(eventID: event.id)
                            }
                        },
                        hasBackground: true,
                        foregroundStyle: .white
                    )
                ]
            )
            .padding(.top, 25)
            
            Spacer()
            
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
                    .padding(.bottom, 35)
                    .padding(.trailing, 24)
            }
        }
    }
}
