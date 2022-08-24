//
//  ViewExtensions.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 24.08.2022.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func userInteractionDisabled() -> some View {
        self.modifier(NoHitTesting())
    }
}
