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
    @State private var isResetPasswordPresented = false

    init(router: StartRouter) {
        self._viewModel = StateObject(wrappedValue: AuthViewModel(router: router))
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let horizontalPadding = screenWidth * 0.1
                let iconPadding = screenWidth * 0.3
                let smallPadding = screenWidth * 0.05

                VStack(alignment: .leading) {
                    // Логотип и заголовок
                    logoAndTitle(iconPadding: iconPadding, horizontalPadding: horizontalPadding)
                    
                    // Поля ввода
                    emailTextField(horizontalPadding: horizontalPadding)
                    passwordTextField(horizontalPadding: horizontalPadding)
                    
                    // Напоминание и Сброс пароля
                    rememberAndForgotPassword(horizontalPadding: horizontalPadding, smallPadding: smallPadding)
                    
                    // Кнопка "Войти"
                    BlueButtonWithArrow(text: signInText) {
                        Task {
                            await viewModel.signIn()
                        }
                    }
                    .padding(.top, smallPadding)
                    .padding(.horizontal, horizontalPadding)
                    
                    // Альтернатива через Google
                    orGoogleSignIn(horizontalPadding: horizontalPadding, smallPadding: smallPadding)
                    
                    Spacer()
                    
                    // Переход на регистрацию
                    footerSignUp(smallPadding: smallPadding)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .navigationBarHidden(true)
                .sheet(isPresented: $isResetPasswordPresented) {
                    ResetPassView(viewModel: viewModel)
                }
            }
        }
    }

    private func logoAndTitle(iconPadding: CGFloat, horizontalPadding: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(iconImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 58)
                .padding(.leading, iconPadding)
            
            Text(title)
                .airbnbCerealFont(.medium, size: 35)
                .padding(.leading, iconPadding - 40)
        }
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
    
    private func passwordTextField(horizontalPadding: CGFloat) -> some View {
        AuthTextField(
            textFieldText: $viewModel.password,
            placeholder: "Your password".localized,
            imageName: "Lock",
            isSecure: true
        )
        .padding(.horizontal, horizontalPadding)
    }
    
    private func rememberAndForgotPassword(horizontalPadding: CGFloat, smallPadding: CGFloat) -> some View {
        HStack(spacing: 20) {
            Toggle("", isOn: $isRememberMeOn)
                .toggleStyle(SwitchToggleStyle(tint: Color.appBlue))
                .labelsHidden()
            
            Text(rememberMeText)
                .airbnbCerealFont(.book, size: 14)
            
            Button {
                isResetPasswordPresented.toggle()
            } label: {
                Text(forgotPasswordText)
                    .airbnbCerealFont(.book, size: 14)
                    .foregroundColor(.appBlue)
            }
            .padding(.leading, smallPadding)
        }
        .padding(.top, smallPadding)
        .padding(.leading, horizontalPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func orGoogleSignIn(horizontalPadding: CGFloat, smallPadding: CGFloat) -> some View {
        VStack(spacing: smallPadding) {
            Text("OR".localized)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, smallPadding)
            
            GoogleButton {
                Task {
                    await viewModel.signInWithGoogle()
                }
            }
            .padding(.horizontal, horizontalPadding)
        }
    }
    
    private func footerSignUp(smallPadding: CGFloat) -> some View {
        NavigationLink(destination: SignUpView(viewModel: viewModel)) {
            HStack {
                Text(dontHaveAnAccText)
                    .airbnbCerealFont(.book, size: 15)
                    .foregroundColor(.black)
                
                Text(signUpText)
                    .airbnbCerealFont(.book, size: 15)
                    .foregroundColor(.appBlue)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, smallPadding)
        }
    }
}

#Preview {
    SignInView(router: StartRouter())
}
