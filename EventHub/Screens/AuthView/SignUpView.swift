//
//  SignUpView.swift
//  EventHub
//
//  Created by Emir Byashimov on 22.11.2024.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        ZStack {
            BackgroundWithEllipses()
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let horizontalPadding = screenWidth * 0.1
                let smallPadding = screenWidth * 0.05
                
                ZStack {
                    VStack {
                        ToolBarView(title: "Sign up".localized, showBackButton: true)
                        VStack {
                            AuthTextField(
                                textFieldText: $name,
                                placeholder: "Full name".localized,
                                imageName: "profile",
                                isSecure: false
                            )
                            .padding(.top, smallPadding / 2)
                            
                            AuthTextField(
                                textFieldText:  $email,
                                placeholder: "Your email".localized,
                                imageName: "mail",
                                isSecure: false
                            )
                            .padding(.top, smallPadding)
                            
                            passwordTextField(horizontalPadding: horizontalPadding, placeholder: "Your password".localized, textFieldText: $password)
                                .padding(.top, smallPadding)
                            
                            passwordTextField(horizontalPadding: horizontalPadding, placeholder: "Confirm password".localized, textFieldText: $confirmPassword)
                                .padding(.top, smallPadding)
                            
                            BlueButtonWithArrow(text: "Sign up".localized) {
                                Task {
                                    try? await viewModel.createUser(name: name, email: email, password: password, repeatPassword: confirmPassword)
                                }
                                
                            }
                            .padding(.top, smallPadding * 1.5)
                            .disabled(viewModel.isLoading)
                            
                            Text("OR")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, smallPadding / 2)
                            
                            GoogleButton() {
                                Task {
                                    await viewModel.signInWithGoogle()
                                }
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text("Already have an account?".localized)
                                    .airbnbCerealFont(.book, size: 15)
                                
                                Text("Sign In".localized)
                                    .airbnbCerealFont(.book, size: 15)
                                    .foregroundColor(.appBlue)
                            }
                            .onTapGesture {
                                dismiss()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, smallPadding)
                        }
                        .padding(.top, smallPadding * 1.5)
                        .padding(.horizontal, horizontalPadding)
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
    
    private func passwordTextField(horizontalPadding: CGFloat, placeholder: String, textFieldText: Binding<String>) -> some View {
        AuthTextField(
            textFieldText: textFieldText,
            placeholder: placeholder,
            imageName: "Lock",
            isSecure: true
        )
    }
}
