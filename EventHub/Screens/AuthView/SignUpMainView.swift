//
//  SignUpView.swift
//  EventHub
//
//  Created by Emir Byashimov on 22.11.2024.
//

import SwiftUI
import FirebaseAuth
struct SignUpMainView: View {
    @ObservedObject var viewModel: AuthViewModel
    
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
                    
                    passwordTextField(horizontalPadding: horizontalPadding, placehholder: "Your password", textFieldText: $viewModel.password)
                        .padding(.top, smallPadding)
                    
                    passwordTextField(horizontalPadding: horizontalPadding, placehholder: "Confirm password", textFieldText: $viewModel.password2)
                        .padding(.top, smallPadding)
                    
                    BlueButtonWithArrow(text: "Sign Up") {
                        Task{
                            let sucess =  await viewModel.signUp()
                            if sucess{
                                viewModel.saveUsernameToUserDefaults(username: viewModel.name )
                                //navigation 
                            }
                        }
                        
                    }
                    .padding(.top, smallPadding * 1.5)
                    .padding(.horizontal, horizontalPadding)
                    
                    Text("OR")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, smallPadding / 2)
                    
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
            textFieldText: $viewModel.name,
            placeholder: "Full name",
            imageName: "profile",
            isSecure: false
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func emailTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText:  $viewModel.email,
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

}
