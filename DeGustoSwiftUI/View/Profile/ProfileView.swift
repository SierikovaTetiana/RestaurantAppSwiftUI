//
//  ProfileView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var userAutorization: UserAutorization
    @Binding var tabSelection: Int
    @State var showImagePicker: Bool = false
    @State var text = ""
    @State var userName = ""
    @State var phoneNumber = ""
    @State var password = ""
    @State var email = ""
    @State var address = ""
    @State var bDay = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                headerView
                Spacer()
                rowsView
                logOut
                Spacer()
                socialButtons
            }
        }.alert(isPresented: $profileViewModel.isPresentingAlertError, content: {
            Alert(
                title: Text("Сталася помилка"),
                message: Text(profileViewModel.errorDescription),
                dismissButton: .default(Text("Добре"))
            )
        })
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(tabSelection: .constant(1))
    }
}
