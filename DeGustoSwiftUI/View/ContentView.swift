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
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var checkOutViewModel = CheckOutViewModel()
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertSheet = false
    
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
        }.alert(isPresented: $userAutorization.isPresentingAlertError, content: {
            Alert(
                title: Text("Сталася помилка"),
                message: Text(userAutorization.errorDescription),
                dismissButton: .default(Text("Добре"))
            )
        })
        .alert(isPresented: $showAlertSheet, content: {
                    if monitor.isConnected {
                        return Alert(title: Text("Success!"), message: Text("The network request can be performed"), dismissButton: .default(Text("OK")))
                    }
                    return Alert(title: Text("No Internet Connection"), message: Text("Please enable Wifi or Celluar data"), dismissButton: .default(Text("Cancel")))
                })
        .environmentObject(mainViewModel)
        .environmentObject(sliderImagesViewModel)
        .environmentObject(userAutorization)
        .environmentObject(cartViewModel)
        .environmentObject(profileViewModel)
        .environmentObject(checkOutViewModel)
        .onAppear(perform: {
            self.showAlertSheet = true
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            if mainViewModel.menu.isEmpty {
                sliderImagesViewModel.fetchSliderImages()
                mainViewModel.fetchMenu {
                    userAutorization.autorizeUser()
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
//TODO: check network
