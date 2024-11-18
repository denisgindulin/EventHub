//
//  SecureTextField.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 18.11.2024.
//

import SwiftUI

struct SecureTextField: View {
    @State var isShowPassword: Bool = true
    @Binding var textFieldText: String
    
    let placeholder: String
    
    var body: some View {
        HStack {
            if isShowPassword {
                SecureField(placeholder, text: $textFieldText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            } else {
                TextField(placeholder, text: $textFieldText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
            Button {
                isShowPassword.toggle()
            } label: {
                if isShowPassword {
                    Image(systemName: "eye.fill")
                        .font(.system(size: 14))
                } else {
                    Image(.eyeSlash)
                }
            }
            .foregroundStyle(.appDarkGray)
        }
    }
}
