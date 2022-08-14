//
//  LoginView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct LoginView: View {
    @State var text = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("logo")
                    .padding(.top)
                Spacer()
                textFields
                logInAndRememberPasswordButtons
                Spacer()
                continueWithFacebook
                Spacer()
                createNewAccount
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension LoginView {
    
    var textFields: some View {
        VStack(alignment: .leading) {
            TextField("Адреса електроної пошти", text: $text)
                .padding(.bottom)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField("Пароль", text: $text)
                .padding(.top)
                .textFieldStyle(OvalTextFieldStyle())
        }.padding()
    }
    
    var logInAndRememberPasswordButtons: some View {
        VStack {
            Button {
                print("pressed go to account")
            } label: {
                Text("ВХІД")
                    .foregroundColor(Color("darkGreen"))
                    .font(.largeTitle)
            }
            Button {
                print("pressed remember password")
            } label: {
                Text("Нагадати пароль")
                    .foregroundColor(.gray)
                    .font(.title3)
            }.padding(.top)
        }
    }
    
    var continueWithFacebook: some View {
        Button {
            print("continue with facebook")
        } label: {
            Image("continueWithFacebook")
                .resizable()
                .scaledToFit()
                .frame(height: 60, alignment: .center)
        }.padding()
    }
    
    var createNewAccount: some View {
        Button {
            print("pressed create new account")
        } label: {
            Text("Створити новий акаунт")
                .foregroundColor(Color("darkGreen"))
                .font(.title2)
        }.padding()
    }
}
