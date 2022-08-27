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
    @EnvironmentObject var cartViewModel: CartViewModel
    @State var takeAwayOrDelivery = 0
    @State var commentToOrder = ""
    @State var readyToNow = true
    @State var deliveryDate = Date()
    @State var userName = ""
    @State var phoneNumber = ""
    @State var address = ""
    @State var showBanner = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "Замовлення успішно відправлено", detail: "Чекайте інформацію про готовність", type: .Success)
    
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
            }.banner(data: $bannerData, show: $showBanner)
        }
        .onTapGesture { hideKeyboard() }
        .onAppear(perform: {
            takeAwayOrDelivery = checkOutViewModel.orderModel.takeAway == TakeAway.takeAway.description ? 0 : 1
            if profileViewModel.userInfo.userDaysInApp == nil {
                profileViewModel.getInfoAboutUser()
            }
        })
        .onDisappear(perform: { performChanges() })
    }
    
    func performChanges() {
        let takeAway = takeAwayOrDelivery == 0 ? TakeAway.takeAway.description : TakeAway.delivery.description
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.takeAway, fieldToChangeInFirebase: "delivery", valueToChange: takeAway)
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.name, fieldToChangeInFirebase: "user", valueToChange: profileViewModel.userInfo.userName ?? userName)
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.phone, fieldToChangeInFirebase: "phoneNumber", valueToChange: profileViewModel.userInfo.phoneNumber ?? phoneNumber)
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.deliveryAddress, fieldToChangeInFirebase: "deliveryAddress", valueToChange: profileViewModel.userInfo.address ?? address)
        if commentToOrder != "" {
            checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.comment, fieldToChangeInFirebase: "comment", valueToChange: commentToOrder)
        }
        checkOutViewModel.changeUserCheckOutInfo(keyPathForUserInfo: \OrderModel.userID, fieldToChangeInFirebase: "userID", valueToChange: Auth.auth().currentUser?.uid ?? "")
        
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
