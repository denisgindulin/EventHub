//
//  SignOutButton.swift
//  EventHub
//
//  Created by Денис Гиндулин on 24.11.2024.
//

import SwiftUI

// это компонент Кнопка Sign Out. Для экранов My profile и Edit profile
struct SignOutButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(.signOut)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 23/375, height: UIScreen.main.bounds.width * 23/375)
                Text("Sign Out")
                    .foregroundStyle(.titleFont)
                    .airbnbCerealFont(.book, size: 16)
            }
        }
    }
}

#Preview {
    SignOutButton(action: {})
}
