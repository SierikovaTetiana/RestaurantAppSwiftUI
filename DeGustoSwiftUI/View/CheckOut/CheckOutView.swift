//
//  CheckOutView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct CheckOutView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State private var takeAwayOrDelivery = 0
    @State var text = ""
    @State var readyToNow = true
    @State private var currentDate = Date()
    
    @State var userName = ""
    @State var phoneNumber = ""
    
    var body: some View {
        VStack {
            pickerView
            personalData
            userComment
            readyTo
            Spacer()
            bottomText
            sendOrder
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backNavButton)
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
    }
}

extension CheckOutView {
    var pickerView: some View {
        VStack(alignment: .leading) {
            Text("Як Ви хочете отримати своє замовлення?")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            Picker("", selection: $takeAwayOrDelivery) {
                Text("Самовивіз").tag(0)
                Text("Доставка").tag(1)
            }
            .pickerStyle(.segmented)
        }.padding()
    }
    
    var personalData: some View {
        VStack(alignment: .leading) {
            Text("Персональні дані")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
//            ProfileTextFieldView(image: ProfileModelForListView.userName.image, description: profileViewModel.userInfo.userName ?? ProfileModelForListView.userName.description, textIsEmpty: profileViewModel.userInfo.userName?.isEmpty ?? true, text: userName)
//            ProfileTextFieldView(image: ProfileModelForListView.phoneNumber.image, description: profileViewModel.userInfo.phoneNumber ?? ProfileModelForListView.phoneNumber.description, textIsEmpty: profileViewModel.userInfo.phoneNumber?.isEmpty ?? true, text: phoneNumber)
        }.padding()
    }
    
    var userComment: some View {
        VStack(alignment: .leading) {
            Text("Коментар до замовлення")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            TextField("Ваші побажання", text: $text)
                .multilineTextAlignment(.leading)
            Divider()
        }.padding()
    }
    
    var readyTo: some View {
        VStack(alignment: .leading) {
            Text("Приготувати до:")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
                .padding(.bottom)
            HStack {
                Button {
                    readyToNow = true
                    print("ready to now")
                } label: {
                    Text("Як можна скоріше")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(Color.black)
                }
                Spacer()
                if readyToNow {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color("darkGreen"))
                }
            }
            Divider()
            HStack {
                Button {
                    readyToNow = false
                    print("ready to now")
                } label: {
                    DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                }
                Spacer()
                if !readyToNow {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color("darkGreen"))
                }
            }
            Divider()
        }.padding()
    }
    
    var bottomText: some View {
        Text("Оплатити замовлення Ви можете за допомогою терміналу чи готівкою")
            .font(.system(.callout, design: .rounded))
            .foregroundColor(Color("darkGreen"))
            .padding(.bottom)
    }
    
    var sendOrder: some View {
        Button(action: {
            print("Go to the menu")
        }) {
            Text("Відправити замовлення")
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 250, height: 50)
                .background(Color("darkRed"))
                .clipShape(Capsule())
        }
        .foregroundColor(.white)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
    
    var backNavButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("darkGreen"))
                Text("Змінити замовлення")
                    .foregroundColor(Color("darkGreen"))
            }
        }
    }
}
