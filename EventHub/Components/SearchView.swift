//
//  SearchView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 28.11.2024.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var text: String
    
    
    let events: [EventDTO]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color.appBackground
                
                VStack(spacing: 10) {
                    ToolBarView(title: "Search",
                                isTitleLeading: false,
                                showBackButton: true,
                                backButtonAction: {} )
                    
                    SearchBarView(searchText: $text,
                                  textColor: .black,
                                  placeholderColor: .searchBarPlaceholder,
                                  fiterAction: {_ in },
                                  magnifierColor: .appBlue,
                                  action: {  })
                        .padding(.horizontal,24)
                }
                .offset(y: -360)
                .zIndex(1)
                
                
//                if events.isEmpty {
//                    Text("No results".uppercased())
//                        .airbnbCerealFont(AirbnbCerealFont.bold, size: 26)
//                } else {
                    
                    ScrollView {
                        VStack {
//                            ForEach(events) { event in
//                                SmallEventCard(image: ,
//                                               date: <#T##Date#>,
//                                               title: <#T##String#>,
//                                               place: <#T##String#>)
//                            }
                            
                            
                        }
                    }
//                } // if end
            }
        }
    }
   
}

#Preview {
    SearchView(text: .constant(""), events: [])
}
