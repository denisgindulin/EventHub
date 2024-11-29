//
//  EditButton.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 26.11.2024.
//

import SwiftUI

struct EditButton: View {
    
    var body: some View {
            HStack(spacing: 14) {
                Image(.edit)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.appBlue)
                Text("Edit Profile")
                    .foregroundStyle(.appBlue)
                    .airbnbCerealFont( AirbnbCerealFont.medium, size: 16)
            }
            .frame(width: 154, height: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(style: .init(lineWidth: 2))
                    .foregroundStyle(.appBlue)
        }
    }
}

#Preview {
    EditButton()
}
