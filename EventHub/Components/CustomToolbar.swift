//
//  CustomToolbar.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct CustomToolBar: View {
    
    private let searchText: String = ""
    
    @Binding var currentLocation: String
    
    @Binding var title: String
    @Binding var isSearchPresented: Bool
    
    let isNotifications: Bool
    let filterAction: (DisplayOrderType) -> Void
    
    let magnifierColor: Color = .white
    let textColor: Color = .white
    
    
    let locations: [EventLocation]
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    
                    Menu {
                        ForEach(locations, id: \.name) { location in
                            Button {
                                currentLocation = location.slug
                                title = location.name ?? "no location name"
                            } label: {
                                Text(location.name ?? "no location name")
                            }
                        }
                    } label: {
                        Text("Current Location")
                            .airbnbCerealFont( AirbnbCerealFont.book, size: 12)
                            .frame(width: 99, height: 14, alignment: .leading)
                            .foregroundStyle(Color.white)
                            .opacity(0.7)
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 10, height: 5)
                            .foregroundStyle(Color.white)
                            .opacity(0.7)
                    }
                    
                    Text(title)
                        .foregroundStyle(Color.white)
                        .airbnbCerealFont(AirbnbCerealFont.book, size: 13)
                }
                
                Spacer()
                
                Button{
                    // show natifications
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.filterButton)
                        
                        ZStack(alignment: .topTrailing) {
                            Image(.notificationsBell)
                                .resizable()
                                .frame(width: 15, height: 16)
                            
                            if isNotifications {
                                Image(.notificationsDot)
                                    .resizable()
                                    .frame(width: 5, height: 5)
                            }
                        }
                    }
                    .clipShape(Circle())
                    .frame(width: 36, height: 36)
                }
                
            }
            .padding(.horizontal,24)
            .padding(.bottom, 10)
            
            SearchBarViewForMap (
                isSearchPresented: $isSearchPresented,
                searchText: .constant(searchText),
                textColor: textColor,
                magnifierColor: magnifierColor,
                shouldHandleTextInput: false,
                fiterAction: filterAction
            )
            .padding(.horizontal,24)
            
        }
        .frame(height: 179)
        .frame(maxWidth: .infinity)
        .background(.appBlue)
        .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft,.bottomRight]))
        
    }
}

#Preview {
    CustomToolBar(
        currentLocation: .constant("City "),
        title: .constant("City "),
        isSearchPresented: .constant(true),
        isNotifications: true,
        filterAction: {_ in },
        locations: []
    )
}
