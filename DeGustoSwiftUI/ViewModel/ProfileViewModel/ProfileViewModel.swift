//
//  ProfileViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case name
    case phone
    case password
    case email
    case bDay
    
    var description: String {
        switch self {
        case .name: return "Ваше ім'я"
        case .phone: return "Ваш номер телефону"
        case .password: return "Ваш пароль"
        case .email: return "Ваш email"
        case .bDay: return "Ваше День Народження"
        }
    }
    
    var image: String {
        switch self {
        case .name: return "person"
        case .phone: return "phone"
        case .password: return "key"
        case .email: return "envelope"
        case .bDay: return "gift"
        }
    }
}
