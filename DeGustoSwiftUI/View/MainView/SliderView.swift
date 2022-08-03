//
//  SliderView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 03.08.2022.
//

import SwiftUI

struct ImageView: View {
    let postImages: SliderImage
    var body: some View {
        Image(uiImage: postImages.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 400, height: 200)
    }
}

struct SliderView2: View {
    @ObservedObject var mainViewModel = MainViewModel()
//    let postImages: SliderImage
    
    var body: some View {
//        scrollView
//        ScrollView(.horizontal) {
//            HStack(spacing: 20) {
//                ForEach(mainViewModel.sliderImages, id: \.self) { image in
////                    ImageView(postImages: image)
////                    Image(uiImage: postImages.image)
////                        .resizable()
////                        .aspectRatio(contentMode: .fit)
////                        .frame(width: 400, height: 200)
//                }
//            }
//            .padding(.horizontal)
//        }
//        .padding(.top)
        Text("rgadgr")
            .background(Color.red)
    }
    
    var scrollView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(mainViewModel.sliderImages, id: \.self) { post in
                        ImageView(postImages: post)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
}
