//
//  AuthViewModel.swift
//  EventHub
//
//  Created by Emir Byashimov on 24.11.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
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
class AuthViewModel: ObservableObject{
    @Published  var name: String = ""
    @Published  var email: String = ""
    @Published  var password2: String = ""
    @Published  var password: String = ""
    @Published var user: User?
    @Published var errorMessage: String = ""
    @Published var authenticationState: authStatus = .unauthenticated
    @Published var displayName: String = ""
    
    let actions: SignInActions
    
    init(actions: SignInActions) {
        self.actions = actions
        registerAuthStateHandler()
    }
    
    func showMainView() {
        actions.showMainScreen()
    }
    
    func close() {
        actions.closed()
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
    func signIn() async -> Bool{
        authenticationState = .authenticating
        do{
            try await  Auth.auth().signIn(withEmail: email, password: password)
            return true
        }
        catch {
            print(error)
                 errorMessage = error.localizedDescription
                 authenticationState = .unauthenticated
                 return false
        }
    }
    
    
    //MARK: - Sign Up
    func signUp() async -> Bool {
       guard  validateFields() else { return false }
        authenticationState = .authenticating
        do{
            try await  Auth.auth().createUser(withEmail: email, password: password)
            return true
        }
        catch{
            print(error)
                 errorMessage = error.localizedDescription
                 authenticationState = .unauthenticated
                 return false
        }
        
    }
    //MARK: - Sign out
    func signOut() async -> Bool {
        do{
            try Auth.auth().signOut()
            return true
        }
        catch{
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
       //MARK: -  Method for ensuring ClientId isValid
       guard let clientID = FirebaseApp.app()?.options.clientID else {
           fatalError()
       }
       let config = GIDConfiguration(clientID: clientID)
       GIDSignIn.sharedInstance.configuration = config
 
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let window = windowScene.windows.first,
             let rootViewController = window.rootViewController else {
           print(ErrorMessages.controllerError)
         return false
       }

         do {
           let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

           let user = userAuthentication.user
             guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: ErrorMessages.idMissing) }
           let accessToken = user.accessToken

           let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                          accessToken: accessToken.tokenString)

           let result = try await Auth.auth().signIn(with: credential)
           let firebaseUser = result.user
             print(" \(ErrorMessages.userPrompt) \(firebaseUser.uid) \(ErrorMessages.withEmail) \(firebaseUser.email ?? ErrorMessages.unknownError)")
           return true
         }
         catch {
           print(error.localizedDescription)
           self.errorMessage = error.localizedDescription
           return false
         }
     }
    
    
    
}
