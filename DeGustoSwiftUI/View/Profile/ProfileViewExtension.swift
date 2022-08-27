//
//  ProfileViewExtension.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 27.08.2022.
//

import SwiftUI

extension ProfileView {
    var headerView: some View {
        HStack {
            Text(profileViewModel.userInfo.userDaysInApp ?? "")
                .foregroundColor(Color("darkGreen"))
                .font(.title2)
            Spacer()
            Button {
                self.showImagePicker.toggle()
                
            } label: {
                if profileViewModel.userInfo.userPhoto == nil {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                } else {
                    profileViewModel.userInfo.userPhoto!
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                }
            }
        }
        .animation(Animation.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: UUID())
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.profileViewModel.loadPhoto(image: image)
            }
        }
        .padding([.leading, .bottom, .trailing])
    }
    
    var rowsView: some View {
        VStack(spacing: 20) {
            ProfileTextFieldView(image: ProfileModelForListView.username.image, description: profileViewModel.userInfo.userName ?? ProfileModelForListView.username.description, textIsEmpty: profileViewModel.userInfo.userName?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.userName, fieldToChangeInFirebase: ProfileModelForListView.username.rawValue, text: userName)
            ProfileTextFieldView(image: ProfileModelForListView.phoneNumber.image, description: profileViewModel.userInfo.phoneNumber ?? ProfileModelForListView.phoneNumber.description, textIsEmpty: profileViewModel.userInfo.phoneNumber?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.phoneNumber, fieldToChangeInFirebase: ProfileModelForListView.phoneNumber.rawValue, text: phoneNumber)
            ProfileTextFieldView(image: ProfileModelForListView.password.image, description: ProfileModelForListView.password.description, textIsEmpty: false, keyPathForUserInfo: \ProfileModel.password, fieldToChangeInFirebase: ProfileModelForListView.password.rawValue, text: password)
            ProfileTextFieldView(image: ProfileModelForListView.email.image, description: profileViewModel.userInfo.email ?? ProfileModelForListView.email.description, textIsEmpty: profileViewModel.userInfo.email?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.email, fieldToChangeInFirebase: ProfileModelForListView.email.rawValue, text: email)
            ProfileTextFieldView(image: ProfileModelForListView.address.image, description: profileViewModel.userInfo.address ?? ProfileModelForListView.address.description, textIsEmpty: profileViewModel.userInfo.address?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.address, fieldToChangeInFirebase: ProfileModelForListView.address.rawValue, text: address)
            ProfileTextFieldView(image: ProfileModelForListView.bDay.image, description: profileViewModel.userInfo.bDay ?? ProfileModelForListView.bDay.description, textIsEmpty: profileViewModel.userInfo.bDay?.isEmpty ?? true, keyPathForUserInfo: \ProfileModel.bDay, fieldToChangeInFirebase: ProfileModelForListView.bDay.rawValue, text: bDay)
        }.padding(.bottom)
            .animation(Animation.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: UUID())
    }
    
    var logOut: some View {
        Button {
            userAutorization.logout()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Вийти з акаунту")
                .foregroundColor(Color("darkGreen"))
                .font(.title)
                .padding(.top)
        }
    }
    
    var socialButtons: some View {
        VStack {
            Text("Офіційні сторінки DeGusto")
                .foregroundColor(Color("darkGreen"))
                .font(.title3)
                .padding(.bottom)
            HStack(spacing: 30) {
                Link(destination: URL(string: "https://www.facebook.com/trattoria.degusto/")!) {
                    Image("facebook")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60, alignment: .center)
                }
                
                Link(destination: URL(string: "https://degustotrattoria.kh.ua")!) {
                    Image(systemName: "network")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("darkRed"))
                        .frame(height: 60, alignment: .center)
                }
                
                Link(destination: URL(string: "https://www.instagram.com/degusto.trattoria/")!) {
                    Image("Inst")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60, alignment: .center)
                }
            }
        }.padding()
    }
}
