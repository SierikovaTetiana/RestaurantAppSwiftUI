//
//  ContentView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 01.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    @StateObject var mainViewModel = MenuViewModel()
    @StateObject var sliderImagesViewModel = SliderImagesViewModel()
    @StateObject var userAutorization = UserAutorization()
    @StateObject var cartViewModel = CartViewModel()
    
    var body: some View {
        TabView(selection: $tabSelection) {
            MenuView(tabSelection: $tabSelection)
                .tabItem {
                    Image("menuButton").resizable().aspectRatio(contentMode: .fit)
                    Text("Головна")
                }
                .tag(1)
            
            MapView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "map")
                    Text("Ми на мапі")
                }
                .tag(2)
        }
        .environmentObject(mainViewModel)
        .environmentObject(sliderImagesViewModel)
        .environmentObject(userAutorization)
        .environmentObject(cartViewModel)
        .onAppear(perform: {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            if mainViewModel.menu.isEmpty {
                self.sliderImagesViewModel.fetchSliderImages()
                self.mainViewModel.fetchMenu {
                    UserAutorization.userAutorization.autorizeUser {_ in
                        cartViewModel.fetchUserCart(menu: mainViewModel.menu)
                        self.mainViewModel.fetchUserFavorites {
                            self.mainViewModel.fetchSectionMenuImage()
                        }
                    }
                }
            }
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
