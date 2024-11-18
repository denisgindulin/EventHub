//
//  AuthTextField.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 18.11.2024.
//

import SwiftUI

struct AuthTextField: View {
    @FocusState private var isFocused: Bool
    
    @Binding var textFieldText: String
    
    let placeholder: String
    let imageName: String
    
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(imageName)
                .foregroundStyle(isFocused ? .appBlue : .appDarkGray)
            if isSecure {
                SecureTextField(textFieldText: $textFieldText, placeholder: placeholder)
                    .focused($isFocused)
            } else {
                TextField(placeholder, text: $textFieldText)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 56)
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            if isFocused {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.appBlue), lineWidth: 1)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.fieldGray), lineWidth: 1)
            }
        }
        .onTapGesture {
            isFocused = true
        }
    }
}
