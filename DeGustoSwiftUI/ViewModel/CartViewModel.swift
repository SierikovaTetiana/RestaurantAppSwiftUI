//
//  CartViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import Foundation
import Firebase

@MainActor final class CartViewModel: ObservableObject {
    
    @Published var cartDishData = [CartModel]()
    @Published var totalCart = TotalCart()
    let faveSectionInMenu = "Улюблене"
    
    func fetchUserCart(menu: [SectionData]) {
        //remove fave section when user loged out
        if menu[0].title == faveSectionInMenu {
            cartDishData.removeAll()
            totalCart = TotalCart()
        }
        
        guard let userUid = Auth.auth().currentUser?.uid else { return }
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
            self.countTotalCart()
        }
    }
    
    func addChangesToCountDish(dish: DishData, price: Int, addDish: Bool) {
        var count = 0
        var dishFromDishData = cartDishData.first(where: { $0.dishTitle == dish.dishTitle })
        count = dishFromDishData?.count ?? 0
        count = addDish ? count + 1 : count - 1
        if count <= 0 {
            cartDishData.removeAll(where: { $0.dishTitle == dish.dishTitle })
        } else {
            if count <= 1 && addDish == true {
                cartDishData.append(CartModel(dishTitle: dish.dishTitle, count: count, price: price))
            } else {
                dishFromDishData?.count = count
                for index in cartDishData.indices {
                    if cartDishData[index].dishTitle == dish.dishTitle {
                        cartDishData[index].count = count
                    }
                }
            }
        }
        updateCountDataInFirebase(dish: dish, count: count)
        countTotalCart()
    }
    
    private func updateCountDataInFirebase(dish: DishData, count: Int) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        lazy var docRef = Firestore.firestore().collection("users").document(userUid)
        if count != 0 {
            docRef.updateData(["cart.\(dish.dishTitle)": count]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                }
            }
        } else {
            docRef.updateData([
                "cart.\(dish.dishTitle)": FieldValue.delete(),
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                }
            }
        }
    }
    
    private func countTotalCart() {
        var totalPieces = 0
        var totalPrice = 0
        for item in cartDishData {
            totalPrice += item.price * item.count
            totalPieces += item.count
        }
        totalCart = TotalCart(totalPrice: totalPrice, totalPieces: totalPieces, dishes: cartDishData)
    }
}
