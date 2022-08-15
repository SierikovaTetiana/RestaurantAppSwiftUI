//
//  TotalInTheCartButton.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 09.08.2022.
//

import SwiftUI

struct TotalInTheCartButton: View {
    
    let screenWidth: CGFloat
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationLink(destination: {
            FullCartView()
        }) {
            Text("У кошику \(cartViewModel.totalCart.totalPieces) товар на суму \(cartViewModel.totalCart.totalPrice) грн.")
                .foregroundColor(.white)
                .frame(width: screenWidth, height: 50)
                .background(Color("darkRed").opacity(0.8))
        }
    }
}
