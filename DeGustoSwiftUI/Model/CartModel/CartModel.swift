//
//  CartData.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 08.08.2022.
//

import UIKit

struct TotalCart {
    var totalPrice : Int = 0
    var totalPieces : Int = 0
    var dishes : [CartModel] = []
}

struct CartModel: Identifiable, Hashable {
    var id = UUID()
    var dishTitle : String = ""
    var count : Int = 0
    var priceOneDish : Int = 0
    var priceOfDishes : Int = 0
    var dishImage : UIImage?
    var dishImgName : String = ""
}
