//
//  SearchView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 28.11.2024.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var text: String
    @State private var isSearchPresented = true
    
    let events: [EventDTO]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color.appBackground
                
                VStack(spacing: 10) {
                    ToolBarView(title: "Search",
                                isTitleLeading: false,
                                showBackButton: true)
                    
                    SearchBarView(isSearchPresented: $isSearchPresented,
                                  searchText: $text,
                                  textColor: .black,
                                  placeholderColor: .searchBarPlaceholder,
                                  fiterAction: {_ in },
                                  magnifierColor: .appBlue,
                                  action: {  })
                        .padding(.horizontal,24)
                }
                .offset(y: -360)
                .zIndex(1)
                
                
                if events.isEmpty {
                    Text("No results".uppercased())
                        .airbnbCerealFont(AirbnbCerealFont.bold, size: 26)
                } else {
                    
                    ScrollView {
                        VStack {
                            ForEach(events) { event in
                                SmallEventCard(image: "sdd",
                                               date: Date.now,
                                               title: " example test",
                                               place: " Home test")
                                
                            }
                        }
                    }
                } // if end
            }
        }.offset(y: 40)
        }
   
}

//#Preview {
//    SearchView(text: .constant(""), isSearchPresented: , events: [])
//}
