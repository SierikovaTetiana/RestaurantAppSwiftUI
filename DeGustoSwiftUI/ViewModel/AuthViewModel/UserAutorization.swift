//
//  UserAutorization.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 05.08.2022.
//

import Foundation
import Firebase
import FBSDKLoginKit

@MainActor final class UserAutorization: ObservableObject {
    
    @Published var isAnonymous: Bool?
    @Published var forgotPasswordEmailWasSent = false
    @Published var isPresentingAlertError = false
    @Published var errorDescription = ""
    let loginManager = LoginManager()
    
    func autorizeUser() {
        if Auth.auth().currentUser != nil {
            isAnonymous = Auth.auth().currentUser!.isAnonymous
        } else {
            isAnonymous = true
            signInAnonymously()
        }
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                self.isAnonymous = false
            }
        }
    }
    
    func createAccount(withEmail email: String, password: String, phoneNum: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.link (with: credential) { authResult, error in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                guard let userID = authResult?.user.uid else {return}
                Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userID).setData([
                    FirebaseKeys.email: email,
                    FirebaseKeys.phoneNumber: phoneNum,
                    FirebaseKeys.data: Date().timeIntervalSince1970
                ]) { err in
                    if let error = error {
                        self.isPresentingAlertError = true
                        self.errorDescription = error.localizedDescription
                    } else {
                        print("Document added with UserID")
                    }
                }
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isAnonymous = true
            signInAnonymously()
        } catch let signOutError as NSError {
            self.isPresentingAlertError = true
            self.errorDescription = signOutError.localizedDescription
            print("Error signing out: ", signOutError)
        }
    }
    
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                self.forgotPasswordEmailWasSent = true
            }
        }
    }
    
    private func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                guard let userUid = authResult?.user.uid else { return }
                Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid).setData([ FirebaseKeys.favorites: [] ])
                self.isAnonymous = ((Auth.auth().currentUser?.isAnonymous) != nil)
            }
        }
    }
    
    func facebookLogin() {
        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { loginResult, error  in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
                print("Error fb login: ", error.localizedDescription)
            }
            guard let safeToken = AccessToken.current?.tokenString else {return}
            let credential = FacebookAuthProvider.credential(withAccessToken: safeToken)
            Auth.auth().signIn (with: credential) { (authResult, error) in
                if let error = error {
                    self.isPresentingAlertError = true
                    self.errorDescription = error.localizedDescription
                    print("Facebook authentication with Firebase error: ", error)
                }
                self.isAnonymous = false
            }
        }
    }
}
