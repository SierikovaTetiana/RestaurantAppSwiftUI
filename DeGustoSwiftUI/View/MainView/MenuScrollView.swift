//
//  ScrollView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 04.08.2022.
//

import SwiftUI

struct MenuScrollView: View {
    
    @ObservedObject var sliderImagesViewModel: SliderImagesViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(sliderImagesViewModel.sliderImages, id: \.self) { image in
                    ImageView(sliderImages: image)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .animation(.linear, value: sliderImagesViewModel.sliderImages)
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
