//
//  ProfileViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 16.08.2022.
//

import Foundation
import Firebase

@MainActor final class ProfileViewModel: ObservableObject {
    @Published var userInfo = ProfileModel()
    
    func getInfoAboutUser() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection("users").document(userUid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let firstData = document.data() {
                    self.userInfo = ProfileModel(userName: firstData["username"] as? String, phoneNumber: firstData["phoneNumber"] as? String, email: firstData["email"] as? String, bDay: firstData["birthDate"] as? String, userDaysInApp: firstData["data"] as? String)
                    print("self.userInfo", self.userInfo)
                }
            }
        }
    }
}
