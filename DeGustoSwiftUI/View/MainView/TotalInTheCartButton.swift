//
//  TotalInTheCartButton.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 09.08.2022.
//

import SwiftUI

struct TotalInTheCartButton: View {
    
    let screenWidth: CGFloat
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        Button(action: {
            print("Total in the cart")
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("darkRed").opacity(0.8))
                    .frame(width: screenWidth, height: 50)
                Text("У кошику \(cartViewModel.cartDishData.count) товар")
            }
        }
        .foregroundColor(.white)
    }
    
}
