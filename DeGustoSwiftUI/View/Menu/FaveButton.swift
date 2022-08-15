//
//  FaveButton.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 05.08.2022.
//

import SwiftUI

struct FaveButton: View {
    
    @EnvironmentObject var mainViewModel: MenuViewModel
    var dish: DishData
    var sectionIndex: Int?
    
    var body: some View {
        Button(action: {
            guard let sectionIndex = sectionIndex else { return }
            mainViewModel.faveButtonTapped(sectionIndex: sectionIndex, dishIndex: mainViewModel.menu[sectionIndex].data.firstIndex(of: dish))
        }) {
            Image(systemName: "heart.circle")
                .foregroundColor(dish.favorite ? .red : .gray)
                .font(.system(size: 35))
        }
        .background(Color.white)
        .clipShape(Circle())
        .buttonStyle(BorderlessButtonStyle())
        .offset(x: 10, y: -10)
    }
}
