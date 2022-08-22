//
//  ProfileViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 16.08.2022.
//
import UIKit
import SwiftUI
import Firebase

@MainActor final class ProfileViewModel: ObservableObject {
    private let defaults = UserDefaults.standard
    private let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private lazy var url = documents.appendingPathComponent("ProfilePhoto.png")
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
            self.getUserPhoto()
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
    
    private func getUserPhoto() {
        do {
            let data = try Data(contentsOf: url, options: [.mappedIfSafe, .uncached])
            guard let uiImage = UIImage(data: data) else { return }
            userInfo.userPhoto = Image(uiImage: uiImage)
        } catch {
            userInfo.userPhoto = Image(systemName: "person")
            print("Unable to Download User Photo from Disk (\(error))")
        }
    }
    
    func loadPhoto(image: UIImage) {
        guard let imageData = image.pngData() else { return }
        do {
            try imageData.write(to: url)
            defaults.set(url, forKey: "ProfilePhoto")
            userInfo.userPhoto = Image(uiImage: image)
        } catch {
            print("Unable to Write Data to Disk (\(error))")
        }
    }
    
    func changeUserInfo() {
        
        userInfo.userName = "Test Name"
//        changeUserInfoInFirebase(whatToChange: <#T##String#>, value: <#T##String#>)
    }
    
    private func changeUserInfoInFirebase(whatToChange key: String, value: String) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection("users").document(userUid)
        docRef.getDocument { (document, error) in
            docRef.updateData(([key: value]), completion: { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }})
        }
    }
}
