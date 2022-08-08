//
//  CartButton.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import SwiftUI

struct CartButton: View {
    
    @ObservedObject var cartViewModel = CartViewModel()
    @ObservedObject var mainViewModel: MenuViewModel
    let dish: DishData
    let price: Int
    
    var body: some View {
        if cartViewModel.cardDishData.contains(where: { $0.key.dishTitle == dish.dishTitle }) {
            addToCart()
        } else {
            emptyDishCart()
        }
    }
    
    func emptyDishCart() -> some View {
        return Button("У КОШИК") {
            cartViewModel.addToCartPressed(dish: dish, price: price)
        }
        .font(.system(.title2, design: .rounded))
        .foregroundColor(Color("darkGreen"))
        .buttonStyle(BorderlessButtonStyle())
    }
    
    func addToCart() -> some View {
        return HStack {
            Button(action: {
                cartViewModel.minusPressed(dish: dish, price: price)
            }) {
                Image(systemName: "minus")
            }
            .padding(.trailing)
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(Color("darkRed"))
            .font(Font.system(.body).bold())
            
            Text("\(cartViewModel.cardDishData[CartModel(dishTitle: dish.dishTitle)]?.count ?? 0)")
                .font(.system(.title2, design: .rounded))

            Button(action: {
                cartViewModel.addToCartPressed(dish: dish, price: price)
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
