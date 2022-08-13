//
//  ContentView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 01.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            MenuView()
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
        .onAppear(perform: {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
