//
//  CheckOutViewExtension.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 25.08.2022.
//

import SwiftUI

extension CheckOutView {
    var pickerView: some View {
        VStack(alignment: .leading) {
            Text("Як Ви хочете отримати своє замовлення?")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            Picker("", selection: $takeAwayOrDelivery) {
                Text("Самовивіз").tag(0)
                Text("Доставка").tag(1)
            }.onTapGesture {
                takeAwayOrDelivery = takeAwayOrDelivery == 0 ? 1 : 0
            }
            .pickerStyle(.segmented)
        }.padding()
    }
    
    var personalData: some View {
        VStack(alignment: .leading) {
            Text("Персональні дані")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            ProfileTextFieldView(image: ProfileModelForListView.username.image, description: profileViewModel.userInfo.userName ?? ProfileModelForListView.username.description, textIsEmpty: profileViewModel.userInfo.userName?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.userName, fieldToChangeInFirebase: ProfileModelForListView.username.rawValue, text: userName)
            ProfileTextFieldView(image: ProfileModelForListView.phoneNumber.image, description: profileViewModel.userInfo.phoneNumber ?? ProfileModelForListView.phoneNumber.description, textIsEmpty: profileViewModel.userInfo.phoneNumber?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.phoneNumber, fieldToChangeInFirebase: ProfileModelForListView.phoneNumber.rawValue, text: phoneNumber)
            if takeAwayOrDelivery == 1 {
                ProfileTextFieldView(image: ProfileModelForListView.address.image, description: profileViewModel.userInfo.address ?? ProfileModelForListView.address.description, textIsEmpty: profileViewModel.userInfo.address?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.address, fieldToChangeInFirebase: ProfileModelForListView.address.rawValue, text: address)
            }
        }.padding()
    }
    
    var userComment: some View {
        VStack(alignment: .leading) {
            Text("Коментар до замовлення")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            TextField("", text: $commentToOrder)
                .placeholder(when: commentToOrder.isEmpty) {
                Text(checkOutViewModel.orderModel.comment == nil ||
                     checkOutViewModel.orderModel.comment == "" ? "Ваші побажання" : checkOutViewModel.orderModel.comment!)
                        .foregroundColor(checkOutViewModel.orderModel.comment == nil ||
                                         checkOutViewModel.orderModel.comment == ""
                                         ? .gray : .black)
            }
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
                } label: {
                    DatePicker("", selection: $deliveryDate, displayedComponents: [.date, .hourAndMinute])
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
            performChanges()
            checkOutViewModel.sendOrder(totalInfoAboutCart: cartViewModel.totalCart){ isSuccess in
                showBanner = isSuccess
                cartViewModel.removeAllDishesFromCart()
            }
        }) {
            Text("Відправити замовлення")
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 250, height: 50)
                .background(Color("darkRed"))
                .clipShape(Capsule())
        }
        .padding()
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
