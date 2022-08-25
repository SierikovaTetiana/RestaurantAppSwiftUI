//
//  OrderModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 25.08.2022.
//

import Foundation

struct OrderModel {
    var takeAway: String?
    var name: String?
    var phone: String?
    var comment: String?
    var deliveryAddress: String?
    var readyToDate:  Date?
    var userID: String?
}

enum TakeAway {
    case takeAway
    case delivery
    
    var description: String {
        switch self {
        case .takeAway: return "Самовивіз"
        case .delivery: return "Доставка"
        }
    }
}
