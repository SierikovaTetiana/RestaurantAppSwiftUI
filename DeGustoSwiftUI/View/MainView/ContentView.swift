//
//  ContentView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 01.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mainViewModel = MenuViewModel()
    @ObservedObject var sliderImagesViewModel = SliderImagesViewModel()
    @ObservedObject var userAutorization = UserAutorization()
    @ObservedObject var cartViewModel = CartViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    TabView {
                        ScrollView {
                            VStack {
                                MenuScrollView(sliderImagesViewModel: sliderImagesViewModel, screenWidth: geometry.size.width)
                                MenuTableView(mainViewModel: mainViewModel, cartViewModel: cartViewModel)
                            }
                        }
                        .overlay(
                            VStack {
                                Spacer()
                                if !cartViewModel.cartDishData.isEmpty {
                                    TotalInTheCartButton(screenWidth: geometry.size.width, cartViewModel: cartViewModel)
                                }})
                        .tabItem {
                            Image("menuButton").resizable().aspectRatio(contentMode: .fit)
                            Text("Головна")
                        }
                        MapView()
                            .tabItem {
                                Image(systemName: "map")
                                Text("Ми на мапі")
                            }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo").resizable().aspectRatio(contentMode: .fit)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    // do something
                }) {
                    Image(systemName: "person")
                        .imageScale(.large)
                        .foregroundColor(Color("darkGreen"))
                }, trailing: Button(action: {
                    // do something
                }) {
                    Image(systemName: "cart")
                        .foregroundColor(Color("darkGreen"))
                        .imageScale(.large)
                })
            }.onAppear(perform: {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                self.sliderImagesViewModel.fetchSliderImages()
                self.mainViewModel.fetchMenu {
                    UserAutorization.userAutorization.autorizeUser {_ in
                        cartViewModel.fetchUserCart(menu: mainViewModel.menu)
                    }
                    self.mainViewModel.fetchUserFavorites {
                        self.mainViewModel.fetchSectionMenuImage()
                    }
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
