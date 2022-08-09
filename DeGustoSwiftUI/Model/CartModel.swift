//
//  CartData.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import Foundation

struct TotalCart {
    var totalPrice : Int = 0
    var totalPieces : Int = 0
    var dishes : [CartModel] = []
}

struct CartModel: Hashable {
    var dishTitle : String = ""
    var count : Int = 0
    var price : Int = 0
}
