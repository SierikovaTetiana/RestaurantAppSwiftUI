//
//  MenuView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 12.08.2022.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject var mainViewModel: MenuViewModel
    @StateObject var sliderImagesViewModel: SliderImagesViewModel
    @StateObject var userAutorization: UserAutorization
    @StateObject var cartViewModel: CartViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    ScrollView {
                        VStack {
                            if mainViewModel.isLoading == false {
                                MenuScrollView(sliderImagesViewModel: sliderImagesViewModel, screenWidth: geometry.size.width)
                                MenuTableView(mainViewModel: mainViewModel, cartViewModel: cartViewModel)
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    .overlay(
                        VStack {
                            Spacer()
                            if !cartViewModel.cartDishData.isEmpty {
                                TotalInTheCartButton(screenWidth: geometry.size.width, cartViewModel: cartViewModel)
                            }})
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo").resizable().aspectRatio(contentMode: .fit)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        NavigationLink {
                            if UserAutorization.userAutorization.isAnonymous {
                                LoginView()
                            } else {
                                ProfileView(cartViewModel: cartViewModel, tabSelection: $tabSelection)
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
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(mainViewModel: MenuViewModel(), sliderImagesViewModel: SliderImagesViewModel(), userAutorization: UserAutorization(), cartViewModel: CartViewModel(), tabSelection: .constant(1))
    }
}
