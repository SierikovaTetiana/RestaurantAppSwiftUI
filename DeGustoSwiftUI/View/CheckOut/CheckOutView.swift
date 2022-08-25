//
//  CheckOutView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI
import Firebase

struct CheckOutView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var checkOutViewModel: CheckOutViewModel
    @State var takeAwayOrDelivery = 0
    @State var commentToOrder = ""
    @State var readyToNow = true
    @State var deliveryDate = Date()
    
    @State var userName = ""
    @State var phoneNumber = ""
    @State var address = ""
    
    var body: some View {
        ScrollView {
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
        .onTapGesture { hideKeyboard() }
        .onAppear(perform: {
            if profileViewModel.userInfo.userDaysInApp == nil {
                profileViewModel.getInfoAboutUser {
                    checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.name, fieldToChangeInFirebase: "user", valueToChange: profileViewModel.userInfo.userName ?? "")
                    checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.phone, fieldToChangeInFirebase: "phoneNumber", valueToChange: profileViewModel.userInfo.phoneNumber ?? "")
                    checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.deliveryAddress, fieldToChangeInFirebase: "deliveryAddress", valueToChange: profileViewModel.userInfo.address ?? "")
                }
            }
        })
        .onDisappear(perform: { performChanges() })
    }
    
    func performChanges() {
        let takeAway = takeAwayOrDelivery == 0 ? TakeAway.takeAway.description : TakeAway.delivery.description
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.takeAway, fieldToChangeInFirebase: "delivery", valueToChange: takeAway)
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.comment, fieldToChangeInFirebase: "comment", valueToChange: commentToOrder)
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.userID, fieldToChangeInFirebase: "userID", valueToChange: Auth.auth().currentUser?.uid ?? "")
        
        if checkOutViewModel.orderModel.name == "" ||
            checkOutViewModel.orderModel.deliveryAddress == "" ||
            checkOutViewModel.orderModel.phone == "" {
            checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.name, fieldToChangeInFirebase: "user", valueToChange: userName)
            checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.phone, fieldToChangeInFirebase: "phoneNumber", valueToChange: phoneNumber)
            checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.deliveryAddress, fieldToChangeInFirebase: "deliveryAddress", valueToChange: address)
        }
        
        if deliveryDate != Date(timeIntervalSince1970: 0) {
            checkOutViewModel.changeDeliveryTime(keyPathForUserInfo: \OrderModel.readyToDate, fieldToChangeInFirebase: "readyTo", valueToChange: deliveryDate)
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
    }
}
