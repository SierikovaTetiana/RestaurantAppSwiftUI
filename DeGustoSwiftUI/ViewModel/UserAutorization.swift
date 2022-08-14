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
    var isAnonymous = true
    
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
}
