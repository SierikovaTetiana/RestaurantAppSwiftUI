//
//  CartButton.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import SwiftUI

struct CartButton: View {
    
    @StateObject var cartViewModel: CartViewModel
    @StateObject var mainViewModel: MenuViewModel
    let dish: DishData
    let price: Int
    
    var body: some View {
        if cartViewModel.cartDishData.contains(where: { $0.dishTitle == dish.dishTitle }) {
            addToCart()
        } else {
            emptyDishCart()
        }
    }
    
    func emptyDishCart() -> some View {
        return Button("У КОШИК") {
            cartViewModel.addChangesToCountDish(dish: dish, price: price, addDish: true)
        }
        .font(.system(.title2, design: .rounded))
        .foregroundColor(Color("darkGreen"))
        .buttonStyle(BorderlessButtonStyle())
    }
    
    func addToCart() -> some View {
        return HStack {
            Button(action: {
                cartViewModel.addChangesToCountDish(dish: dish, price: price, addDish: false)
            }) {
                Image(systemName: "minus")
            }
            .padding(.trailing)
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(Color("darkRed"))
            .font(Font.system(.body).bold())
            
            Text("\(cartViewModel.cartDishData[cartViewModel.cartDishData.firstIndex(where: { $0.dishTitle == dish.dishTitle })!].count)")
                .font(.system(.title2, design: .rounded))
            
            Button(action: {
                cartViewModel.addChangesToCountDish(dish: dish, price: price, addDish: true)
            }) {
                Image(systemName: "plus")
            }
            .padding(.horizontal)
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(Color("darkRed"))
            .font(Font.system(.body).bold())
        }
    }
}
