//
//  UserAutorization.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 05.08.2022.
//

import Foundation
import Firebase

class UserAutorization {
    
    static let userAutorization = UserAutorization()
    var userUid = ""
    
    func autorizeUser() {
        if Auth.auth().currentUser != nil {
            userUid = Auth.auth().currentUser!.uid
        } else {
            Auth.auth().signInAnonymously { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    guard let user = authResult?.user else { return }
                    self.userUid = user.uid
                    Firestore.firestore().collection("users").document(self.userUid).setData([ "favorites": [] ])
                }
            }
        }
    }
}
