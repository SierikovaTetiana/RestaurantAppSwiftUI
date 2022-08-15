//
//  UserAutorization.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 05.08.2022.
//

import Foundation
import Firebase

@MainActor final class UserAutorization: ObservableObject {
    
    static let userAutorization = UserAutorization()
    var userUid = String()
    @Published var isAnonymous = true
    
    func autorizeUser(completion:@escaping (String) -> ()) {
        if Auth.auth().currentUser != nil {
            userUid = Auth.auth().currentUser!.uid
            isAnonymous = Auth.auth().currentUser!.isAnonymous
            completion(self.userUid)
        } else {
            Auth.auth().signInAnonymously { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    guard let user = authResult?.user else { return }
                    self.userUid = user.uid
                    Firestore.firestore().collection("users").document(self.userUid).setData([ "favorites": [] ])
                    self.isAnonymous = ((Auth.auth().currentUser?.isAnonymous) != nil)
                    completion(self.userUid)
                }
            }
        }
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                print("Sucessfully loged in!")
            }
        }
    }
    
    func createAccount(withEmail email: String, password: String, phoneNum: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.link (with: credential) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                guard let userID = authResult?.user.uid else {return}
                Firestore.firestore().collection("users").document(userID).setData([
                    "email": email,
                    "phoneNumber": phoneNum,
                    "data": Date().timeIntervalSince1970
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
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
            isAnonymous = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
