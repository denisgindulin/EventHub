//
//  ResetPassView.swift
//  EventHub
//
//  Created by Emir Byashimov on 30.11.2024.
//

import SwiftUI

struct ResetPassView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) private var presentationMode // Для закрытия экрана

    let emailReqText = "Please enter your email address to request a password reset".localized
    @State private var showSuccessMessage: Bool = false
    @State private var showErrorMessage: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ToolBarView(title: "Reset password".localized, showBackButton: true)
                .padding(.bottom, 60)
                .padding(.top, 20)
            
            Text(emailReqText)
                .airbnbCerealFont(.book, size: 15)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            emailTextField(horizontalPadding: 29)
                .padding(.top, 36)
            
            BlueButtonWithArrow(text: "Change password".localized) {
                handleResetPassword()
            }
            .padding(.top, 40)
            .padding(.horizontal, 52)
            .disabled(viewModel.isLoading || viewModel.email.isEmpty)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private func emailTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $viewModel.email,
            placeholder: "Your email".localized,
            imageName: "mail",
            isSecure: false
        )
        .padding(.horizontal, horizontalPadding)
    }
    
    private func handleResetPassword() {
        Task {
            viewModel.isLoading = true
            let success = await viewModel.resetPassword(email: viewModel.email)
            viewModel.isLoading = false
            
            if success {
                withAnimation {
                    showErrorMessage = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                withAnimation {
                    showSuccessMessage = false
                    showErrorMessage = true
                }
            }
        }
    }
}

#Preview {
    ResetPassView(viewModel: AuthViewModel(router: StartRouter()))
}
