//
//  ProfileView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct ProfileView: View {
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var userAutorization: UserAutorization
    @Binding var tabSelection: Int
    @State var showImagePicker: Bool = false
    
    @State var userName = ""
    @State var phoneNumber = ""
    @State var password = ""
    @State var email = ""
    @State var bDay = ""
    
    var body: some View {
        VStack {
            Spacer()
            headerView
            Spacer()
            rowsView
            logOut
            Spacer()
            socialButtons
        }
        .onTapGesture { hideKeyboard() }
        .onAppear(perform: {
            if profileViewModel.userInfo.userDaysInApp == nil {
                profileViewModel.getInfoAboutUser()
            }
        })
        .navigationTitle("Профіль")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: NavigationLink {
                if cartViewModel.cartDishData.isEmpty {
                    EmptyCartView(tabSelection: $tabSelection)
                } else {
                    FullCartView()
                }
            } label: {
                Image(systemName: "cart")
                    .foregroundColor(Color("darkGreen"))
                    .imageScale(.large)
            })
    }
}

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
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.profileViewModel.loadPhoto(image: image)
            }
        }
        .padding([.leading, .bottom, .trailing])
    }
    
    var rowsView: some View {
        VStack(spacing: 20) {
            ProfileTextFieldView(image: ProfileModelForListView.userName.image, description: profileViewModel.userInfo.userName ?? ProfileModelForListView.userName.description, textIsEmpty: profileViewModel.userInfo.userName?.isEmpty ?? true, fieldName: \ProfileModel.userName, text: userName)
            ProfileTextFieldView(image: ProfileModelForListView.phoneNumber.image, description: profileViewModel.userInfo.phoneNumber ?? ProfileModelForListView.phoneNumber.description, textIsEmpty: profileViewModel.userInfo.phoneNumber?.isEmpty ?? true, fieldName: \ProfileModel.phoneNumber, text: phoneNumber)
            ProfileTextFieldView(image: ProfileModelForListView.password.image, description: ProfileModelForListView.password.description, textIsEmpty: false, fieldName: \ProfileModel.password, text: password)
            ProfileTextFieldView(image: ProfileModelForListView.email.image, description: profileViewModel.userInfo.email ?? ProfileModelForListView.email.description, textIsEmpty: profileViewModel.userInfo.email?.isEmpty ?? true, fieldName: \ProfileModel.email, text: email)
            ProfileTextFieldView(image: ProfileModelForListView.bDay.image, description: profileViewModel.userInfo.bDay ?? ProfileModelForListView.bDay.description, textIsEmpty: profileViewModel.userInfo.bDay?.isEmpty ?? true, fieldName: \ProfileModel.bDay, text: bDay)
        }.padding(.bottom)
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
                Button {
                    print("facebook")
                } label: {
                    Image("facebook")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60, alignment: .center)
                }
                
                Button {
                    print("site")
                } label: {
                    Image(systemName: "network")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("darkRed"))
                        .frame(height: 60, alignment: .center)
                }
                
                Button {
                    print("instagram")
                } label: {
                    Image("Inst")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60, alignment: .center)
                }
            }
        }.padding()
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(tabSelection: .constant(1))
    }
}
