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
                    self.userInfo = ProfileModel(userName: firstData["username"] as? String, phoneNumber: firstData["phoneNumber"] as? String, email: firstData["email"] as? String, bDay: firstData["birthDate"] as? String, userDaysInApp: self.countUserDaysInApp(days: firstData["data"] as? Double))
                }
            }
        }
    }
    
    private func countUserDaysInApp(days: Double?) -> String {
        if let countTerm = days {
            let unixtime = NSDate().timeIntervalSince1970
            let difference = Int((unixtime - countTerm)/86400)
            if difference <= 1 {
                return "Ви з нами вже 1 день"
            } else if difference < 5 {
                return "Ви з нами вже \(difference) дні"
            } else {
                return "Ви з нами вже \(difference) днів"
            }
        }
        return ""
    }
}
