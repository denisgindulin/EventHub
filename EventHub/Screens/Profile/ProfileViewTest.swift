//
//  ProfileViewTest.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 26.11.2024.
//

import SwiftUI

struct ProfileViewTest: View {
    
    @State private var showEdit = false
    let userName: String = "Ashfak Sayem"
    let imageSize: CGFloat = 96
    
    var body: some View {
        VStack {
            
            Text("Profile")
                .airbnbCerealFont( AirbnbCerealFont.medium, size: 24)
            
            Image(systemName: "face.smiling.inverse")
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
           
            Text(userName)
            
            EditButton(action: { showEdit = true; print("edit button tapped") })
            
            
            Text("About Me")
            
            Text("Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More") // add link Read More
            
            
            SignOutButton(action: { } )
        }
        
        .padding(.top, 50)
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileViewTest()
}
