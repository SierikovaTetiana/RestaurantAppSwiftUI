//
//  ProfileViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import Foundation
import SwiftUI

enum ProfileModelForListView: String, CaseIterable {
    case username
    case phoneNumber
    case password
    case email
    case bDay
    
    var description: String {
        switch self {
        case .username: return "Ваше ім'я"
        case .phoneNumber: return "Ваш номер телефону"
        case .password: return "*******"
        case .email: return "Ваш email"
        case .bDay: return "Ваш День Народження"
        }
    }
    
    var image: Image {
        switch self {
        case .username: return Image(systemName: "person")
        case .phoneNumber: return Image(systemName: "phone")
        case .password: return Image(systemName: "key")
        case .email: return Image(systemName: "envelope")
        case .bDay: return Image(systemName: "gift")
        }
    }
}
