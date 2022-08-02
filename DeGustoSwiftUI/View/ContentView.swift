//
//  ContentView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 01.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    VStack{
                        scrollView
                        tableView
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
            }, trailing: Button(action: {
                // do something
            }) {
                Image(systemName: "cart")
                    .imageScale(.large)
            })
            
        }.onAppear(perform: {
            self.mainViewModel.fetchSliderImages()
        })
    }
    
    var scrollView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                
//                ForEach(0..<mainViewModel.sliderImages.count) {
//                for item in mainViewModel.sliderImages {
//                    Text("Item \($0)")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
//                        .frame(width: 300, height: 200)
//                        .background(.red)
//                }
            }
        }
        .padding(.top)
    }
    
    var tableView: some View {
        List {
            Text(mainViewModel.test)
        }
        .listStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
