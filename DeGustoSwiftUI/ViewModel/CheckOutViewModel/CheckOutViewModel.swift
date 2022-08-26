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
        print(orderModel)
    }
    
    func changeDeliveryTime(keyPathForUserInfo: WritableKeyPath<OrderModel, Date?>, fieldToChangeInFirebase: String, valueToChange: Date) {
        orderModel[keyPath: keyPathForUserInfo] = valueToChange
    }
    
    func sendOrder() {
        print(orderModel)
//        guard let user = Auth.auth().currentUser?.uid else { return }
//        Firestore.firestore().collection("orders").document(user).setData([
//            "user": orderModel.name ?? "",
//            "phoneNumber": orderModel.phone ?? "",
//            "delivery": orderModel.takeAway ?? "",
//            "deliveryAddress": orderModel.deliveryAddress ?? "",
//            "comment": orderModel.comment ?? "",
//            "readyTo": orderModel.readyToDate ?? "",
//            "userID": orderModel.userID ?? ""
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
////                let banner = FloatingNotificationBanner(title: "Заказ не был отправлен", subtitle: "Попробуйте повторить снова. Ошибка: \(err)", style: .danger)
////                banner.show()
//            } else {
//                print("Document successfully written!")
////                let banner = FloatingNotificationBanner(title: "Заказ успешно отправлен", subtitle: "Ждите информацию про готовность", style: .success)
////                banner.show()
//            }
//        }
    }
}




//TODO: add all Firebase keys in the separate file
