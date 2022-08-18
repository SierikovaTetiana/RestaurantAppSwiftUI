//
//  MenuView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 12.08.2022.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var mainViewModel: MenuViewModel
    @EnvironmentObject var sliderImagesViewModel: SliderImagesViewModel
    @EnvironmentObject var userAutorization: UserAutorization
    @EnvironmentObject var cartViewModel: CartViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    ScrollView {
                        VStack {
                            if mainViewModel.isLoading == false {
                                MenuScrollView(screenWidth: geometry.size.width)
                                MenuTableView()
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    .overlay(
                        VStack {
                            Spacer()
                            if !cartViewModel.cartDishData.isEmpty {
                                TotalInTheCartButton(screenWidth: geometry.size.width)
                            }})
                }
                .onChange(of: userAutorization.isAnonymous, perform: {_ in
                    cartViewModel.fetchUserCart(menu: mainViewModel.menu)
                    mainViewModel.fetchUserFavorites { }
                })
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo").resizable().aspectRatio(contentMode: .fit)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        NavigationLink {
                            if userAutorization.isAnonymous {
                                LoginView(tabSelection: $tabSelection)
                            } else {
                                ProfileView(tabSelection: $tabSelection)
                            }
                        } label: {
                            Image(systemName: "person")
                                .imageScale(.large)
                                .foregroundColor(Color("darkGreen"))
                        },
                    trailing:
                        NavigationLink {
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
            }.accentColor(Color("darkGreen"))
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(tabSelection: .constant(1))
    }
}
