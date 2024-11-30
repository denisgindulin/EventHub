//
//  SearchView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 28.11.2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var text: String
    @State private var isSearchPresented = true
    
    let events: [EventDTO]
    
    let test = [ EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil),EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil),EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil),EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil) ]
    
    let action: () -> Void
    
    var body: some View {
        
        ZStack {
            
            Color.appBackground
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    
                    Text("Search")
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: 24)
                    
                    SearchBarView(isSearchPresented: $isSearchPresented,
                                  searchText: $text,
                                  textColor: .black,
                                  placeholderColor: .searchBarPlaceHolderView,
                                  fiterAction: {_ in },
                                  magnifierColor: .appBlue,
                                  action: action )
                    .padding(.horizontal,24)
                    .padding(.top, 30)
                }
                .zIndex(1)
                
                
                //            if events.isEmpty {
                //                Text("No results".uppercased())
                //                    .airbnbCerealFont(AirbnbCerealFont.bold, size: 26)
                //            } else {
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(test) { event in // << events array
                            NavigationLink(destination: DetailView(detailID: event.id)) {
                                SmallEventCard(image: event.images.first?.image ?? "No image", date: Date.now, title: event.title ?? " No title", place: "No place",showPlace: false)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom,5)
                                
                            }

                        }
                    }
                }
                .padding(.top,30)
                
                //            } // if
            }
            
            
            
        }
        .offset(y: -40)//  подогнал ZS
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBarButtonView(foregroundStyle: .black)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}

#Preview {
    SearchView(text: .constant(" Trump "), events: [ EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil),EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil),EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil),EventDTO(id: 234, title:" marat event", images: [ImageDTO(image: "ecfes")], description: nil, bodyText: nil, favoritesCount: 3, dates: [EventDate(start: 1, end: 1, startDate: "", startTime: "", endTime: "")], place: nil, location: nil, participants: nil) ], action: {})
}
