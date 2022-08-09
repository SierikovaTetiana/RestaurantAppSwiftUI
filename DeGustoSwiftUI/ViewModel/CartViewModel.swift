//
//  CartViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import Foundation
import Firebase

class CartViewModel: ObservableObject {
    
    @Published var cartDishData = [CartModel]()
    //    @Published var totalCart = TotalCart()
    
    func fetchUserCart(menu: [SectionData]) {
        let userUid = UserAutorization.userAutorization.userUid
        let docRef = Firestore.firestore().collection("users").document(userUid)
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else { return }
            guard let firstData = document.data() else { return }
            guard let cartData = firstData["cart"] as? Dictionary<String, Int> else { return }
            for item in cartData {
                for index in menu.indices {
                    if let indexOfDish = menu[index].data.firstIndex(where: { $0.dishTitle == item.key }) {
                        self.cartDishData.append(CartModel(dishTitle: item.key, count: item.value, price: menu[index].data[indexOfDish].price))
                    }
                }
            }
//            print(self.cartDishData[cartDishData.firstIndex(where: { $0.dishTitle == dish.dishTitle })].count)
        }
    }
    
    func addChangesToCountDish(dish: DishData, price: Int, addDish: Bool) {
        let userUid = UserAutorization.userAutorization.userUid
        lazy var docRef = Firestore.firestore().collection("users").document(userUid)
        var count = 0
        var dishFromDishData = cartDishData.first(where: { $0.dishTitle == dish.dishTitle })
        count = dishFromDishData?.count ?? 0
        count = addDish ? count + 1 : count - 1
        if count <= 0 {
            cartDishData.removeAll(where: { $0.dishTitle == dish.dishTitle })
        } else {
            if count <= 1 {
                cartDishData.append(CartModel(dishTitle: dish.dishTitle, count: count, price: price))
            } else {
                dishFromDishData?.count = count
            }
            docRef.updateData(["cart.\(dish.dishTitle)": count]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Updated", count)
                }
            }
        }
    }
    
}
