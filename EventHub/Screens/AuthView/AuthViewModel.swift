//
//  AuthViewModel.swift
//  EventHub
//
//  Created by Emir Byashimov on 24.11.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

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
    private let db = Firestore.firestore()
    private let router: StartRouter
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password2: String = ""
    @Published var password: String = ""
    @Published var user: User?
    @Published var errorMessage: String = ""
    @Published var authenticationState: authStatus = .unauthenticated
    @Published var displayName: String = ""
    
    @Published var isLoading: Bool = false
    
//    MARK: - INIT
    init(router: StartRouter) {
        self.router = router
      registerAuthStateHandler()
    }
    
    // MARK: - Handle Whether User Logged or not
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
            }
        }
    }
    
    //MARK: - Sign In
    func signIn() async {
        authenticationState = .authenticating
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            await fetchUserData() // Загрузка данных пользователя
            userAuthenticated()
        } catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
        }
    }
    
    
    //MARK: - Sign Up
    func signUp() async -> Bool {
        guard validateFields() else { return false }
        authenticationState = .authenticating
        isLoading = true
        
        do {
            // Создание пользователя в Firebase Authentication
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // Сохранение данных пользователя в Firestore
            let userData: [String: Any] = [
                "email": email,
                "username": name.isEmpty ? "Unknown" : name,
                "avatar": "",
                "description": "",
                "favorites": ""
            ]
            try await db.collection("users").document(result.user.uid).setData(userData)
            
            // Пользователь успешно создан
            userAuthenticated()
            return true
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
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
    
    func updateUserData(updatedData: [String: Any]) async -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "No authenticated user found"
            return false
        }
        
        do {
            try await db.collection("users").document(uid).updateData(updatedData)
            print("User data updated successfully")
            return true
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func fetchUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "No authenticated user found"
            return
        }
        
        do {
            let snapshot = try await db.collection("users").document(uid).getDocument()
            if let data = snapshot.data() {
                name = data["username"] as? String ?? "Unknown"
                email = data["email"] as? String ?? ""
                // Дополнительные поля, если есть
            }
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
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
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
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
