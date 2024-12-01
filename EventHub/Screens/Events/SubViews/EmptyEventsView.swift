//
//  EmptyEventsView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 26.11.2024.
//

import SwiftUI

struct EmptyEventsView: View {
    
    @State var selectedMode: EventsMode
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image(.schedule)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 202, height: 202)
                .clipShape(Circle())
                      
            
            Text(selectedMode == .upcoming 
                 ? "No Upcoming Event".localized
                 : "No Past Event".localized)
                .airbnbCerealFont(.bold, size: 24)
                .foregroundStyle(.black)
            
            
            Text("Lorem ipsum dolor sit amet, consectetur")
                .airbnbCerealFont(.bold, size: 16)
                .lineLimit(2)
                .foregroundStyle(.appLightGray)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width: UIScreen.main.bounds.width * 0.85)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    EmptyEventsView(selectedMode: .upcoming)
}
