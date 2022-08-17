//
//  ProfileViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import Foundation

enum ProfileModelForListView: String, CaseIterable {
    case userName
    case phoneNumber
    case password
    case email
    case bDay
    
    var description: String {
        switch self {
        case .userName: return "Ваше ім'я"
        case .phoneNumber: return "Ваш номер телефону"
        case .password: return "Ваш пароль"
        case .email: return "Ваш email"
        case .bDay: return "Ваше День Народження"
        }
    }
    
    var image: String {
        switch self {
        case .userName: return "person"
        case .phoneNumber: return "phone"
        case .password: return "key"
        case .email: return "envelope"
        case .bDay: return "gift"
        }
    }
}
