//
//  ProfileViewTest.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 26.11.2024.
//

import SwiftUI

struct ProfileViewTest: View {
    
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
            
            
            
            
        }
        
        .padding(.top, 50)
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileViewTest()
}
