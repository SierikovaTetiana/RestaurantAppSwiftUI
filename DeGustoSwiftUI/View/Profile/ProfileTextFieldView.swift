//
//  ProfileTextFieldView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 22.08.2022.
//

import SwiftUI

struct ProfileTextFieldView: View {
    var image: Image
    var description: String
    var textIsEmpty: Bool
    @State var text: String
    @State var didEdited = false
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: .leading)
                .foregroundColor(Color("darkGreen"))
            TextField("", text: $text, onEditingChanged: { edited in
                didEdited = edited ? false : true
            })
            .placeholder(when: text.isEmpty) {
                Text(description)
                    .foregroundColor(textIsEmpty ? .gray : .black)
            }
            Spacer()
        }
        .padding(.horizontal)
        .onDisappear {
            if text != "" && didEdited {
                print("TEXT", text, description)
                profileViewModel.changeUserInfo()
            }
        }
        
        Divider()
    }
}
//TODO: Dismiss keyboard when tap outside in other(not Profile) views
extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
