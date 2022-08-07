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
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    TabView {
                        ScrollView {
                            VStack {
                                MenuScrollView(sliderImagesViewModel: sliderImagesViewModel, screenWidth: geometry.size.width)
                                MenuTableView(mainViewModel: mainViewModel)
                            }
                        }
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
                    self.mainViewModel.fetchUserFavorites {
                        self.mainViewModel.fetchSectionMenuImage()
                    }
                }
                UserAutorization.userAutorization.autorizeUser()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
