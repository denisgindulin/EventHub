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
                                textFieldText: $viewModel.nameSU,
                                placeholder: "Full name".localized,
                                imageName: "profile",
                                isSecure: false
                            )
                            .padding(.top, smallPadding / 2)
                            
                            AuthTextField(
                                textFieldText:  $viewModel.emailSU,
                                placeholder: "Your email".localized,
                                imageName: "mail",
                                isSecure: false
                            )
                            .padding(.top, smallPadding)
                            
                            passwordTextField(horizontalPadding: horizontalPadding, placeholder: "Your password".localized, textFieldText: $viewModel.passwordSU)
                                .padding(.top, smallPadding)
                            
                            passwordTextField(horizontalPadding: horizontalPadding, placeholder: "Confirm password".localized, textFieldText: $viewModel.confirmPasswordSU)
                                .padding(.top, smallPadding)
                            
                            BlueButtonWithArrow(text: "Sign up".localized) {
                                Task {
                                    await viewModel.createUser(name: viewModel.nameSU, email: viewModel.emailSU, password: viewModel.passwordSU, repeatPassword: viewModel.confirmPasswordSU)
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
                    .alert(isPresented: isPresentedAlert()) {
                        Alert(
                            title: Text(viewModel.authError == .signUpSuccess ? "Success" : "Error"),
                            message: Text(viewModel.authError?.localizedDescription ?? ""),
                            dismissButton: .default(Text("OK"), action: {
                                if viewModel.authError == .signUpSuccess {
                                    viewModel.cancelErrorAlert()
                                    dismiss()
                                } else {
                                    viewModel.cancelErrorAlert()
                                }
                            })
                        )
                    }
                }

            }
        }
    }
    
    private func isPresentedAlert() -> Binding<Bool> {
        Binding(get: { viewModel.authError != nil },
                set: { isPresenting in
            if isPresenting { return }
        })
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
