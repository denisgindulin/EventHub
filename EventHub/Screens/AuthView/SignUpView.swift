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
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let horizontalPadding = screenWidth * 0.1
            let smallPadding = screenWidth * 0.05
            
            
            ZStack {
                VStack {
                    ToolBarView(title: "Sign up".localized, showBackButton: true)

                    nameTextField(horizontalPadding: horizontalPadding)
                        .padding(.top, smallPadding / 2)
                    
                    emailTextField(horizontalPadding: horizontalPadding)
                        .padding(.top, smallPadding)
                    
                    passwordTextField(horizontalPadding: horizontalPadding, placeholder: "Your password".localized, textFieldText: $viewModel.password)
                        .padding(.top, smallPadding)
                    
                    passwordTextField(horizontalPadding: horizontalPadding, placeholder: "Confirm password".localized, textFieldText: $viewModel.password2)
                        .padding(.top, smallPadding)
                    
                    BlueButtonWithArrow(text: "Sign up".localized) {
                        Task{
                            let sucess =  await viewModel.signUp()
                            if sucess {
                                viewModel.saveUsernameToUserDefaults(username: viewModel.name )
                                 
                                withAnimation {
                                    //
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                        
                    }
                    .padding(.top, smallPadding * 1.5)
                    .padding(.horizontal, horizontalPadding)
                    .disabled(viewModel.isLoading)
                    
                    Text("OR")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, smallPadding / 2)
                    
                    GoogleButton() {
                        Task {
                            await viewModel.signInWithGoogle()
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    
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
            }
            .navigationBarHidden(true)
        }
    }
    
    private func nameTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $viewModel.name,
            placeholder: "Full name".localized,
            imageName: "profile",
            isSecure: false
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func emailTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText:  $viewModel.email,
            placeholder: "Your email".localized,
            imageName: "mail",
            isSecure: false
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func passwordTextField(horizontalPadding: CGFloat, placeholder: String, textFieldText: Binding<String>) -> some View {
        AuthTextField(
            textFieldText: textFieldText,
            placeholder: placeholder,
            imageName: "Lock",
            isSecure: true
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
}

#Preview {
    SignUpView(viewModel: AuthViewModel(router: StartRouter()))
}
