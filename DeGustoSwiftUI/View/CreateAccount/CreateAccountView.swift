//
//  CreateAccountView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var text = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .padding(.vertical)
            Spacer()
            textFields
            Spacer()
            registrationButton
            Spacer()
            policyRules
            Spacer()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backNavButton)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

extension CreateAccountView {
    var textFields: some View {
        VStack(alignment: .leading) {
            TextField("Адреса електроної пошти", text: $text)
                .padding(.bottom)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField("Пароль", text: $text)
                .padding(.top)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextField("+380991234567", text: $text)
                .padding(.top)
                .textFieldStyle(OvalTextFieldStyle())
        }.padding()
    }
    
    var registrationButton: some View {
        Button {
            print("pressed registration")
        } label: {
            Text("Регістрація")
                .foregroundColor(Color("darkGreen"))
                .font(.largeTitle)
        }.padding()
    }
    
    var policyRules: some View {
        Text("При вході ви автоматично приймаєте \n політику конфеденційності")
            .font(.system(.callout, design: .rounded))
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var backNavButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("darkGreen"))
                Text("Меню")
                    .foregroundColor(Color("darkGreen"))
            }
        }
    }
}
