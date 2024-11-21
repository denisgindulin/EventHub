//
//  GoogleButton.swift
//  EventHub
//
//  Created by Emir Byashimov on 21.11.2024.
//

import SwiftUI

struct GoogleButton: View {
    
    var iconImageName = "google"
    var buttonText: LocalizedStringKey = LocalizedStringKey("Login with Google")
    var buttonColor: Color = .black
    var buttonBackColor: Color = .white
    var shadow: Color = Color(red: 0.83, green: 0.83, blue: 0.89)
    var buttonCornerRadius: CGFloat = 12
    var buttonHeight: CGFloat = 56
    let action: () -> Void
    
    
    var body: some View {
        Button{
            action()
        } label: {
            HStack(alignment: .center, spacing: 30) {
                Image(iconImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 26)
                
                Text(buttonText)
                    .airbnbCerealFont(.book , size: 16)
                    .foregroundStyle(buttonColor)
                    .lineLimit(1)
            }
        }
        .padding()
        .frame(minWidth: 225, maxWidth: 275)
        .background {
            RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                .fill(buttonBackColor)
        }
        .frame(height: buttonHeight)
        .shadow(color: shadow.opacity(0.25), radius: 15, x: 15, y: 0)
    }
}

#Preview {
    GoogleButton() {
        print("action")
    }
}
