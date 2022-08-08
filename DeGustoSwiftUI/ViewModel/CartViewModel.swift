//
//  CartViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import Foundation
import Firebase

class CartViewModel: ObservableObject {
    
    @Published var cardDishData = [CartModel : CartModelDetails]()
    @Published var totalCart = TotalCart()
    var count = 0
    
    func fetchUserCart() {
        let userUid = UserAutorization.userAutorization.userUid
        let docRef = Firestore.firestore().collection("users").document(userUid)
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else { return }
            guard let firstData = document.data() else { return }
            guard let cartData = firstData["cart"] as? Dictionary<String, Any> else { return }
            for item in cartData {
                print(item.key, "-> ", item.value)
            }
        }
    }
    
    func addToCartPressed(dish: DishData, price: Int) {
        count += 1
        cardDishData[CartModel(dishTitle: dish.dishTitle)] = CartModelDetails(count: count, price: price)
    }
    
    func minusPressed(dish: DishData, price: Int) {
        count -= 1
        if count <= 0 {
            cardDishData.removeValue(forKey: CartModel(dishTitle: dish.dishTitle))
        } else {
            cardDishData[CartModel(dishTitle: dish.dishTitle)] = CartModelDetails(count: count, price: price)
        }
    }
}
