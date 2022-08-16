//
//  LoginView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var userAutorization: UserAutorization
    @Binding var tabSelection: Int
    @State var email = ""
    @State var forgotPasswordEmail = ""
    @State var password = ""
    @State var isLinkActive = false
    @State var showingAlertForgotPassword = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
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
                        .alert("Лист було надіслано на вашу електрону адресу. Будь ласка, перевірте", isPresented: $userAutorization.forgotPasswordEmailWasSent) {
                            Button("Добре") { }
                        }
                }
                .blur(radius: showingAlertForgotPassword ? 10 : 0)
            }.textFieldAlert(isPresented: $showingAlertForgotPassword, title: "Ви дійсно хочете скинути пароль?", message: "Введіть адресу електроної пошти, будь ласка", text: $forgotPasswordEmail, placeholder: "email", action: { text in
                if !text.isEmpty {
                    userAutorization.forgotPassword(email: text)
                }
            })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(tabSelection: .constant(1))
    }
}

extension LoginView {
    
    var textFields: some View {
        VStack(alignment: .leading) {
            TextField("Адреса електроної пошти", text: $email)
                .padding(.bottom)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField("Пароль", text: $password)
                .padding(.top)
                .textFieldStyle(OvalTextFieldStyle())
        }.padding()
    }
    
    var logInAndRememberPasswordButtons: some View {
        VStack {
            NavigationLink(destination: ProfileView(tabSelection: $tabSelection), isActive: $isLinkActive) {
                Button(action: {
                    self.isLinkActive = true
                    userAutorization.login(withEmail: email, password: password)
                }) {
                    Text("ВХІД")
                        .foregroundColor(Color("darkGreen"))
                        .font(.largeTitle)
                }
            }
            Button {
                print("pressed remember password")
                showingAlertForgotPassword = true
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
        NavigationLink {
            CreateAccountView()
        } label: {
            Text("Створити новий акаунт")
                .foregroundColor(Color("darkGreen"))
                .font(.title2)
        }.padding()
    }
}
