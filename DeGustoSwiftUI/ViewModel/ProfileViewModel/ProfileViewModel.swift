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
    @Published var userInfo = ProfileModel()
    @Published var isPresentingAlertError = false
    @Published var errorDescription = ""
    private let defaults = UserDefaults.standard
    private let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private lazy var url = documents.appendingPathComponent("ProfilePhoto.png")
    
    func getInfoAboutUser() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid)
        docRef.getDocument { (document, error) in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            }
            if let document = document, document.exists {
                if let firstData = document.data() {
                    self.userInfo = ProfileModel(userName: firstData[FirebaseKeys.username] as? String, phoneNumber: firstData[FirebaseKeys.phoneNumber] as? String,address: firstData[FirebaseKeys.address] as? String, email: firstData[FirebaseKeys.email] as? String, bDay: firstData[FirebaseKeys.bDay] as? String, userDaysInApp: self.countUserDaysInApp(days: firstData[FirebaseKeys.data] as? Double))
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
        }
    }
    
    func loadPhoto(image: UIImage) {
        guard let imageData = image.pngData() else { return }
        do {
            try imageData.write(to: url)
            defaults.set(url, forKey: "ProfilePhoto")
            userInfo.userPhoto = Image(uiImage: image)
        } catch {
            isPresentingAlertError = true
            errorDescription = error.localizedDescription
        }
    }
    
    func changeUserInfo(keyPathForUserInfo: WritableKeyPath<ProfileModel, String?>, fieldToChangeInFirebase: String, valueToChange: String) {
        userInfo[keyPath: keyPathForUserInfo] = valueToChange
        changeUserInfoInFirebase(whatToChange: fieldToChangeInFirebase, value: valueToChange)
    }
    
    private func changeUserInfoInFirebase(whatToChange key: String, value: String) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid)
        docRef.getDocument { (document, error) in
            docRef.updateData(([key: value]), completion: { err in
                if let error = err {
                    self.isPresentingAlertError = true
                    self.errorDescription = error.localizedDescription
                } else {
                    print("Document successfully updated")
                }})
        }
    }
    
    func changeUserPassword(oldPassword: String, newPassword: String) {
        guard let userEmail = userInfo.email else { return }
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: userEmail, password: oldPassword)
        user?.reauthenticate(with: credential, completion: { (result, error) in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                user?.updatePassword(to: newPassword) { err in
                    if let error = err {
                        self.isPresentingAlertError = true
                        self.errorDescription = error.localizedDescription
                    } else {
                        print("Password successfully updated")
                    }}
            }
        })
    }
}
