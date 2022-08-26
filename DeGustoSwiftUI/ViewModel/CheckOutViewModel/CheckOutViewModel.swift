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
    
    func changeUserCheckOutInfo(keyPathForUserInfo: WritableKeyPath<OrderModel, String?>, fieldToChangeInFirebase: String, valueToChange: String) {
        orderModel[keyPath: keyPathForUserInfo] = valueToChange
    }
    
    func changeDeliveryTime(keyPathForUserInfo: WritableKeyPath<OrderModel, Date?>, fieldToChangeInFirebase: String, valueToChange: Date) {
        orderModel[keyPath: keyPathForUserInfo] = valueToChange
    }
    
    func sendOrder(totalInfoAboutCart: TotalCart) {
        guard let user = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("orders").document(user).setData([
            "user": orderModel.name ?? "",
            "phoneNumber": orderModel.phone ?? "",
            "delivery": orderModel.takeAway ?? "",
            "deliveryAddress": orderModel.deliveryAddress ?? "",
            "comment": orderModel.comment ?? "",
            "readyTo": calculateReadyToTime(),
            "userID": orderModel.userID ?? "",
            "totalPrice": totalInfoAboutCart.totalPrice
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                //"Заказ успешно отправлен"
                var totalOrder = [String:String]()
                for dish in totalInfoAboutCart.dishes {
                    totalOrder["cart.\(dish.dishTitle)"] = "\(dish.count)"
                }
                Firestore.firestore().collection("orders").document(user).updateData(totalOrder) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
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




//TODO: add all Firebase keys in the separate file
