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
    var fieldName: WritableKeyPath<ProfileModel, String?>
    @State var text: String
    @State var oldPassword = ""
    @State var newPassword = ""
    @State var didEdited = false
    @State var showingAlertChangeUserInfo = false
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
            if ProfileModelForListView.password.description == description {
                changePasswordButton
            } else {
                editButton
            }
        }
        .padding(.horizontal)
        //        .textFieldAlert(isPresented: $showingAlertChangeUserInfo, title: "Змініть \(description)", message: "", text: $text, placeholder: description, action: { text in
        //            if !text.isEmpty {
        //                profileViewModel.changeUserInfo(fieldName: fieldName, valueToChange: text)
        //            }
        //        })
        
        .onDisappear {
            if text != "" && didEdited && ProfileModelForListView.password.description != description {
                profileViewModel.changeUserInfo(fieldName: fieldName, valueToChange: text)
            }
        }
        Divider()
    }
}

extension ProfileTextFieldView {
    var editButton: some View {
        return Button {
            showingAlertChangeUserInfo = true
            print("Edit tapped")
        } label: {
            Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .leading)
                .foregroundColor(Color("darkGreen"))
        }
    }
    
    var changePasswordButton: some View {
        NavigationLink {
            ChangePasswordView()
        } label: {
            Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .leading)
                .foregroundColor(Color("darkGreen"))
        }
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
