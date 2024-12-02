//
//  AboutMeInfo.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 28.11.2024.
//

import SwiftUI

struct AboutMeInfo: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    let text: String
    
    var body: some View {
        
        ZStack {

            VStack {
                
                Text("About Me")
                    .airbnbCerealFont( AirbnbCerealFont.book, size: 24)
                    .foregroundStyle(.appBlue)
                    .padding(20)
                
                ScrollView {
                    Text(firebaseManager.user?.info ?? "No Info")
                        .padding(20)
                }
                .frame(width: 360)
                .overlay {
                    RoundedRectangle(cornerRadius: 20).stroke(style: .init(lineWidth: 3))
                        .foregroundStyle(.appBlue)
                }
            }
        }
    }
}

#Preview {
    AboutMeInfo(text: "About ///")
}

