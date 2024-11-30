import SwiftUI
import FirebaseAuth

struct SignInView: View {
    var iconImageName: String = "shortLogo"
    var title = "EventHub".localized
    var signInText = "Sign In".localized
    var rememberMeText = "Remember me".localized
    var forgotPasswordText = "Forgot Password?".localized
    var dontHaveAnAccText = "Don’t have an account?".localized
    var signUpText = "Sign up".localized
    
    @StateObject var viewModel: AuthViewModel
    @State private var isRememberMeOn: Bool = false
    @State private var isPresentedSignUp = false
    @State private var isResetPasswordPresented = false
    @State private var resetEmail: String = ""
    @State private var resetMessage: String = ""
    @State private var showResetConfirmation: Bool = false

    init(router: StartRouter) {
        self._viewModel = StateObject(wrappedValue: AuthViewModel(router: router))
    }

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
                        .toggleStyle(SwitchToggleStyle(tint: Color.appBlue))
                        .labelsHidden()
                    
                    Text(rememberMeText)
                        .airbnbCerealFont(.book, size: 14)
                    
                    Button(action: {
                        isResetPasswordPresented = true
                    }) {
                        Text(forgotPasswordText)
                            .airbnbCerealFont(.book, size: 14)
                            .foregroundColor(.appBlue)
                    }
                    .padding(.leading, smallPadding)
                }
                .padding(.top, smallPadding )
                .padding(.leading, horizontalPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                BlueButtonWithArrow(text: signInText) {
                    Task {
                        await viewModel.signIn()
                    }
                }
                .padding(.top, smallPadding)
                .padding(.horizontal, horizontalPadding)
                
                Text("OR".localized)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, smallPadding)
                
                GoogleButton() {
                    Task {
                        await viewModel.signInWithGoogle()
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
                .onTapGesture {
                    isPresentedSignUp.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, smallPadding)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: SignUpView(viewModel: viewModel),
                    isActive: $isPresentedSignUp
                ) {
                    EmptyView()
                }
            )
            .alert("Reset Password".localized, isPresented: $isResetPasswordPresented) {
                TextField("Enter your email".localized, text: $resetEmail)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                Button("Submit".localized) {
                    if isValidEmail(resetEmail) {
                        Task {
                            let success = await viewModel.resetPassword(email: resetEmail)
                            resetMessage = success ? "Reset email sent successfully!" : viewModel.errorMessage
                            showResetConfirmation = true
                        }
                    } else {
                        resetMessage = "Invalid email format. Please try again."
                        showResetConfirmation = true
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
            .alert(resetMessage, isPresented: $showResetConfirmation) {
                Button("OK", role: .cancel) {}
            }
        }
    }

    private func emailTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $viewModel.email,
            placeholder: "Your email".localized,
            imageName: "mail",
            isSecure: false
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func passwordTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $viewModel.password,
            placeholder: "Your password".localized,
            imageName: "Lock",
            isSecure: true
        )
        .padding(.leading, horizontalPadding)
        .padding(.trailing, horizontalPadding)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    SignInView(router: StartRouter())
}
