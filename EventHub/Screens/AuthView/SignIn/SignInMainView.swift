//
//  SignInView.swift
//  EventHub
//
//  Created by Emir Byashimov on 21.11.2024.
//

import SwiftUI
import FirebaseAuth
struct SignInMainView: View {
    var iconImageName: String = "shortLogo"
    var title: LocalizedStringKey = "EventHub"
    var signInText: LocalizedStringKey = "Sign In"
    var rememberMeText: LocalizedStringKey = "Remember me"
    var forgotPasswordText: LocalizedStringKey = "Forgot Password?"
    var dontHaveAnAccText: LocalizedStringKey = "Don’t have an account?"
    var signUpText: LocalizedStringKey = "Sign up"
    @ObservedObject var viewModel: AuthViewModel
    @State private var isRememberMeOn: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let horizontalPadding = screenWidth * 0.1
            let iconPadding = screenWidth * 0.3
            let smallPadding = screenWidth * 0.05
            
            
            VStack(alignment: .leading) {
                Image(iconImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 58)
                    .padding(.leading, iconPadding)
                
                Text(title)
                    .airbnbCerealFont(.medium, size: 35)
                    .padding(.leading, iconPadding - 40)
                
                Text(signInText)
                    .airbnbCerealFont(.medium, size: 24)
                    .padding(.leading, horizontalPadding)
                    .padding(.top, smallPadding)
                
                emailTextField(horizontalPadding: horizontalPadding)
                passwordTextField(horizontalPadding: horizontalPadding)
                
                HStack(spacing: 20) {
                    Toggle("", isOn: $isRememberMeOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        .labelsHidden()
                    
                    Text(rememberMeText)
                        .airbnbCerealFont(.book, size: 14)
                    
                    Text(forgotPasswordText)
                        .airbnbCerealFont(.book, size: 14)
                        .padding(.leading, smallPadding)
                }
                .padding(.top, smallPadding )
                .padding(.leading, horizontalPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                BlueButtonWithArrow(text: "Sign In") {
                    Task{
                        let sucess =  await viewModel.signIn()
                        if sucess{
                            //
                        }
                    }
                }
                .padding(.top, smallPadding)
                .padding(.horizontal, horizontalPadding)
                
                Text("OR")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, smallPadding)
                
                GoogleButton() {
                    Task{
                        let sucess = await viewModel.signInWithGoogle()
                        if sucess{
                            
                        } else{
                           
                        }
                    }
                   
                }
                .padding(.horizontal, horizontalPadding)
                
                Spacer()
                
                HStack {
                    Text(dontHaveAnAccText)
                        .airbnbCerealFont(.book, size: 15)
                    
                    Text(signUpText)
                        .airbnbCerealFont(.book, size: 15)
                        .foregroundColor(.appBlue)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, smallPadding)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func emailTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $viewModel.email,
            placeholder: "Enter your email",
            imageName: "mail",
            isSecure: false
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func passwordTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $viewModel.password,
            placeholder: "Your password",
            imageName: "Lock",
            isSecure: true
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
}

#Preview {
    SignInMainView(viewModel: AuthViewModel())
}
