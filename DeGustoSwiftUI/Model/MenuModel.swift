//
//  MenuModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 03.08.2022.
//

import UIKit

struct SectionData: Identifiable, Equatable {
    var id = UUID()
    var open : Bool = false
    var data : [DishData] = []
    var title : String = ""
    var sectionImgName : String = ""
    var sectionImage : UIImage?
    var order : Int
}

struct DishData: Identifiable, Equatable, Hashable {
    var id = UUID()
    var dishTitle : String = ""
    var dishImage : UIImage?
    var dishImgName : String = ""
    var description : String = ""
    var weight : Int = 0
    var price : Int = 0
    var favorite : Bool = false
    var cartCount : Int = 0
}
