//
//  AuthViewModel.swift
//  EventHub
//
//  Created by Emir Byashimov on 24.11.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseAuthCombineSwift
import GoogleSignIn


enum authStatus {
    case authenticated
    case unauthenticated
    case authenticating
}
enum AuthenticationFlow {
  case login
  case signUp
}

enum AuthenticationError: Error {
  case tokenError(message: String)
}

enum ErrorMessages {
    static let emailError = "Email or password cannot be empty"
    static let passwordError = "Passwords do not match"
    static let noId = "No client ID found in Firebase configuration"
    static let controllerError = "There is no root view controller!"
    static let idMissing = "ID token missing"
    static let unknownError = "unknown"
    static let withEmail = "signed in with email"
    static let userPrompt: String = "User"
}



@MainActor
final class AuthViewModel: ObservableObject{
    private let firestoreManager = FirestoreManager()
    private let router: StartRouter
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password2: String = ""
    @Published var password: String = ""
    @Published var user: UserData?
    @Published var errorMessage: String = ""
    @Published var authenticationState: authStatus = .unauthenticated
    @Published var displayName: String = ""
    
    @Published var isLoading: Bool = false
    
//    MARK: - INIT
    init(router: StartRouter) {
        self.router = router
    }

    //MARK: - Sign In
    func signIn() async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            userAuthenticated()
            print("Verification was successful")
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    
    //MARK: - Sign Up
    @MainActor
    func createUser(name: String, email: String, password: String, repeatPassword: String) async throws {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                firestoreManager.saveUserData(userId: authResult.user.uid, name: name, email: email)
                try await authResult.user.sendEmailVerification()
            } catch {
                print("Ошибка при регистрации: \(error.localizedDescription)")
                throw error
            }
        }
    }
    
    //MARK: - Sign out
    func signOut() async -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        }
        catch {
            print(error)
                 errorMessage = error.localizedDescription
                 return false
        }
    }
    
    //MARK: - Reset Password
    func resetPassword(email: String) async -> Bool {
      authenticationState = .authenticating
      do {
        try await Auth.auth().sendPasswordReset(withEmail: email)
        print("Password reset email sent to \(email)")
        return true
      } catch {
        print(error.localizedDescription)
        errorMessage = error.localizedDescription
        authenticationState = .unauthenticated
        return false
      }
    }

    //MARK: - Save User to UserDefaults by id
    func saveUsernameToUserDefaults(username: String) {
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user found")
            return
        }
        
        let uid = user.uid
        let key = "username_\(uid)"
        UserDefaults.standard.set(username, forKey: key)
        print("Username '\(username)' saved for user: \(uid)")
    }
    
    //MARK: - Validate Email and Password
    func validateFields() -> Bool {
          if email.isEmpty || password.isEmpty {
              errorMessage = ErrorMessages.emailError
              return false
          }
          
          if password != password2 {
              errorMessage = ErrorMessages.passwordError
              return false
          }
          
          return true
      }
    
    
    // MARK: Google
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            errorMessage = ErrorMessages.noId
            return false
        }
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            errorMessage = ErrorMessages.controllerError
            return false
        }
        do {
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            guard let idToken = userAuthentication.user.idToken else {
                throw AuthenticationError.tokenError(message: ErrorMessages.idMissing)
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken.tokenString,
                accessToken: userAuthentication.user.accessToken.tokenString
            )
            _ = try await Auth.auth().signIn(with: credential)

            await MainActor.run {
                userAuthenticated()
            }
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    //MARK: - NavigationState
    func userAuthenticated() {
        router.updateRouterState(with: .userAuthorized)
    }
}
