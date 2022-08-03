//
//  ContentView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 01.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mainViewModel = MainViewModel()
    @ObservedObject var sliderImagesViewModel = SliderImagesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    VStack {
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
            self.sliderImagesViewModel.fetchSliderImages()
            self.mainViewModel.fetchMenu {
                self.mainViewModel.fetchSectionMenuImage()
            }   
        })
    }
    
    var scrollView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(sliderImagesViewModel.sliderImages, id: \.self) { image in
                    ImageView(sliderImages: image)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
    
    var tableView: some View {
        List {
            ForEach(mainViewModel.menu) { item in
                HStack {
                    Image(uiImage: (item.sectionImage ?? UIImage(systemName: "person"))!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                    
                    Text(item.title)
                        .font(.system(.title3, design: .rounded))
                        .bold()
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ImageView: View {
    let sliderImages: SliderImage
    var body: some View {
        Image(uiImage: sliderImages.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 400, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
