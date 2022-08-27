//
//  ChangePasswordView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 24.08.2022.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var oldPassword = ""
    @State var newPassword = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .padding(.vertical)
            Spacer()
            areYouSureText
            Spacer()
            textFields
            Spacer()
            changePasswordButton
            Spacer()
            Spacer()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backNavButton)
        }.onTapGesture { hideKeyboard() }
            .alert(isPresented: $profileViewModel.isPresentingAlertError, content: {
                Alert(
                    title: Text("Сталася помилка"),
                    message: Text(profileViewModel.errorDescription),
                    dismissButton: .default(Text("Добре"))
                )
            })
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}

extension ChangePasswordView {
    var areYouSureText: some View {
        Text("Ви дійсно хочете змінити пароль? \n \n Будь ласка, введіть свій старий пароль та новий")
            .foregroundColor(Color("darkGreen"))
            .font(.title2)
            .multilineTextAlignment(.center)
    }
    
    var textFields: some View {
        VStack(alignment: .leading) {
            SecureField("Старий пароль", text: $oldPassword)
                .padding(.bottom)
                .textFieldStyle(OvalTextFieldStyle())
            
            SecureField("Новий пароль", text: $newPassword)
                .padding(.top)
                .textFieldStyle(OvalTextFieldStyle())
            
        }.padding()
    }
    
    var changePasswordButton: some View {
        Button {
            if oldPassword != "" && newPassword != "" {
                profileViewModel.changeUserPassword(oldPassword: oldPassword, newPassword: newPassword)
            }
        } label: {
            Text("Змінити пароль")
                .foregroundColor(Color("darkGreen"))
                .font(.title)
        }.padding()
    }
    
    var backNavButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("darkGreen"))
                Text("Мій профіль")
                    .foregroundColor(Color("darkGreen"))
            }
        }
    }
}
