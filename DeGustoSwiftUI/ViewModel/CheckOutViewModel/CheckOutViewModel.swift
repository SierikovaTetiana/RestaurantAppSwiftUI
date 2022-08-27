//
//  CheckOutViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 25.08.2022.
//

import SwiftUI
import Firebase

@MainActor final class CheckOutViewModel: ObservableObject {
    
    @Published var orderModel = OrderModel()
    @Published var isPresentingAlertError = false
    @Published var errorDescription = ""
    
    func changeUserCheckOutInfo(keyPathForUserInfo: WritableKeyPath<OrderModel, String?>, fieldToChangeInFirebase: String, valueToChange: String) {
        orderModel[keyPath: keyPathForUserInfo] = valueToChange
    }
    
    func changeDeliveryTime(keyPathForUserInfo: WritableKeyPath<OrderModel, Date?>, fieldToChangeInFirebase: String, valueToChange: Date) {
        orderModel[keyPath: keyPathForUserInfo] = valueToChange
    }
    
    func sendOrder(totalInfoAboutCart: TotalCart, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection(FirebaseKeys.collectionOrders).document(user).setData([
            FirebaseKeys.user: orderModel.name ?? "",
            FirebaseKeys.phoneNumber: orderModel.phone ?? "",
            FirebaseKeys.delivery: orderModel.takeAway ?? "",
            FirebaseKeys.deliveryAddress: orderModel.deliveryAddress ?? "",
            FirebaseKeys.comment: orderModel.comment ?? "",
            FirebaseKeys.readyTo: calculateReadyToTime(),
            FirebaseKeys.userID: orderModel.userID ?? "",
            FirebaseKeys.totalPrice: totalInfoAboutCart.totalPrice
        ]) { error in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                var totalOrder = [String:String]()
                for dish in totalInfoAboutCart.dishes {
                    totalOrder["\(FirebaseKeys.cart).\(dish.dishTitle)"] = "\(dish.count)"
                }
                Firestore.firestore().collection("orders").document(user).updateData(totalOrder) { error in
                    if let error = error {
                        self.isPresentingAlertError = true
                        self.errorDescription = error.localizedDescription
                    } else {
                        print("Document successfully updated")
                        completion(true)
                    }
                }
            }
        }
    }
    
    private func calculateReadyToTime() -> String {
        var readyToDate = ""
        if orderModel.readyToDate != nil && orderModel.readyToDate! <= Date() {
            readyToDate = "як можна скоріше"
        } else {
            readyToDate = orderModel.readyToDate?.formatted() ?? ""
        }
        return readyToDate
    }
}
