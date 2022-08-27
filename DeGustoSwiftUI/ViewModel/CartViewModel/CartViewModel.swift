//
//  CartViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import UIKit
import Firebase

@MainActor final class CartViewModel: ObservableObject {
    
    @Published var cartDishData = [CartModel]()
    @Published var totalCart = TotalCart()
    @Published var isPresentingAlertError = false
    @Published var errorDescription = ""
    let faveSectionInMenu = "Улюблене"
    
    func fetchUserCart(menu: [SectionData]) {
        //remove fave section when user loged out
        if menu[0].title == faveSectionInMenu {
            cartDishData.removeAll()
            totalCart = TotalCart()
        }
        
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid)
        docRef.getDocument { (document, error) in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            }
            guard let document = document, document.exists else { return }
            guard let firstData = document.data() else { return }
            guard let cartData = firstData[FirebaseKeys.cart] as? Dictionary<String, Int> else { return }
            for item in cartData {
                for index in menu.indices {
                    if let indexOfDish = menu[index].data.firstIndex(where: { $0.dishTitle == item.key }) {
                        let totalDishPrice = menu[index].data[indexOfDish].price * item.value
                        let dishImgName = menu[index].data[indexOfDish].dishImgName
                        let dishImage = menu[index].data[indexOfDish].dishImage
                        if dishImage == nil {
                            self.getDishImage(sectionTitle: menu[index].title, dishImgName: dishImgName) {image in
                                self.cartDishData.append(CartModel(dishTitle: item.key, count: item.value, priceOneDish: menu[index].data[indexOfDish].price, priceOfDishes: totalDishPrice, dishImage: image, dishImgName: dishImgName))
                                self.countTotalCart()
                            }
                        } else {
                            self.cartDishData.append(CartModel(dishTitle: item.key, count: item.value, priceOneDish: menu[index].data[indexOfDish].price, priceOfDishes: totalDishPrice, dishImage: dishImage, dishImgName: dishImgName))
                        }
                    }
                }
            }
            self.countTotalCart()
        }
    }
    
    func addChangesToCountDishFromMenu(dish: DishData, price: Int, addDish: Bool) {
        var count = 0
        var dishFromDishData = cartDishData.first(where: { $0.dishTitle == dish.dishTitle })
        count = dishFromDishData?.count ?? 0
        count = addDish ? count + 1 : count - 1
        if count <= 0 {
            cartDishData.removeAll(where: { $0.dishTitle == dish.dishTitle })
        } else {
            if count <= 1 && addDish == true {
                cartDishData.append(CartModel(dishTitle: dish.dishTitle, count: count, priceOneDish: dish.price, priceOfDishes: dish.price * count, dishImage: dish.dishImage, dishImgName: dish.dishImgName))
            } else {
                dishFromDishData?.count = count
                for index in cartDishData.indices {
                    if cartDishData[index].dishTitle == dish.dishTitle {
                        cartDishData[index].count = count
                        cartDishData[index].priceOfDishes = cartDishData[index].priceOneDish * count
                    }
                }
            }
        }
        updateCountDataInFirebase(dishTitle: dish.dishTitle, count: count)
        countTotalCart()
    }
    
    func addChangesToCountDishFromCart(dish: CartModel, addDish: Bool) {
        var count = dish.count
        count = addDish ? count + 1 : count - 1
        if count <= 0 {
            cartDishData.removeAll(where: { $0.dishTitle == dish.dishTitle })
        } else {
            for index in cartDishData.indices {
                if cartDishData[index].dishTitle == dish.dishTitle {
                    cartDishData[index].count = count
                    cartDishData[index].priceOfDishes = cartDishData[index].priceOneDish * count
                }
            }
        }
        updateCountDataInFirebase(dishTitle: dish.dishTitle, count: count)
        countTotalCart()
    }
    
    func removeAllDishesFromCart() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid)
        docRef.updateData([
            FirebaseKeys.cart: FieldValue.delete(),
        ]) { error in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                self.cartDishData.removeAll()
            }
        }
    }
    
    private func updateCountDataInFirebase(dishTitle: String, count: Int) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        lazy var docRef = Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid)
        if count != 0 {
            docRef.updateData(["\(FirebaseKeys.cart).\(dishTitle)": count]) { error in
                if let error = error {
                    self.isPresentingAlertError = true
                    self.errorDescription = error.localizedDescription
                }
            }
        } else {
            docRef.updateData([
                "\(FirebaseKeys.cart).\(dishTitle)": FieldValue.delete(),
            ]) { error in
                if let error = error {
                    self.isPresentingAlertError = true
                    self.errorDescription = error.localizedDescription
                }
            }
        }
    }
    
    private func countTotalCart() {
        var totalPieces = 0
        var totalPrice = 0
        for item in cartDishData {
            totalPrice += item.priceOneDish * item.count
            totalPieces += item.count
        }
        totalCart = TotalCart(totalPrice: totalPrice, totalPieces: totalPieces, dishes: cartDishData)
    }
    
    private func getDishImage(sectionTitle: String, dishImgName: String, completion: @escaping (UIImage) -> Void) {
        let storageRef = Storage.storage().reference().child(FirebaseKeys.menuImages).child(sectionTitle).child("\(dishImgName).jpg")
        storageRef.getData(maxSize: 1 * 480 * 480) { data, error in
            if let error = error {
                self.isPresentingAlertError = true
                self.errorDescription = error.localizedDescription
            } else {
                guard let imgData = data else { return }
                guard let image = UIImage(data: imgData) else { return }
                completion(image)
            }
        }
    }
}
