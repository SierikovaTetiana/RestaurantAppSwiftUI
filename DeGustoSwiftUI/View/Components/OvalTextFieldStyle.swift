//
//  OvalTextFieldStyle.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 13.08.2022.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray.opacity(0.5), radius: 10)
    }
}
