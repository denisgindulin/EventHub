//
//  SignUpView.swift
//  EventHub
//
//  Created by Emir Byashimov on 22.11.2024.
//

import SwiftUI

struct SignUpMainView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let horizontalPadding = screenWidth * 0.1
            let smallPadding = screenWidth * 0.05
            
            
            ZStack {
                VStack {
                    ToolBarView(title: "Sign Up", showBackButton: true)

                    nameTextField(horizontalPadding: horizontalPadding)
                        .padding(.top, smallPadding / 2)
                    
                    emailTextField(horizontalPadding: horizontalPadding)
                        .padding(.top, smallPadding)
                    
                    passwordTextField(horizontalPadding: horizontalPadding, placehholder: "Your password", textFieldText: $password)
                        .padding(.top, smallPadding)
                    
                    passwordTextField(horizontalPadding: horizontalPadding, placehholder: "Confirm password", textFieldText: $password2)
                        .padding(.top, smallPadding)
                    
                    BlueButtonWithArrow(text: "Sign Up") {
                        print("Action")
                    }
                    .padding(.top, smallPadding * 1.5)
                    .padding(.horizontal, horizontalPadding)
                    
                    Text("OR")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, smallPadding / 2)
                    
                    GoogleButton() {
                        //
                    }
                    .padding(.horizontal, horizontalPadding)
                    
                    Spacer()
                    
                    HStack {
                        Text("Already have an account?")
                            .airbnbCerealFont(.book, size: 15)
                        
                        Text("Sign In")
                            .airbnbCerealFont(.book, size: 15)
                            .foregroundColor(.appBlue)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, smallPadding)
                }
            }
        }
    }
    
    private func nameTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $name,
            placeholder: "Full name",
            imageName: "profile",
            isSecure: false
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func emailTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $email,
            placeholder: "Enter your email",
            imageName: "mail",
            isSecure: false
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func passwordTextField(horizontalPadding: CGFloat, placehholder: String, textFieldText: Binding<String>) -> some View {
        AuthTextField(
            textFieldText: textFieldText,
            placeholder: placehholder,
            imageName: "Lock",
            isSecure: true
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
}

#Preview {
    SignUpMainView()
}
