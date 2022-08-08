//
//  ScrollView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 04.08.2022.
//

import SwiftUI

struct MenuScrollView: View {
    
    @ObservedObject var sliderImagesViewModel: SliderImagesViewModel
    @State private var currentIndex: Int = 0
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let screenWidth: CGFloat
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(0..<sliderImagesViewModel.sliderImages.count, id: \.self) { index in
                        ImageView(sliderImages: sliderImagesViewModel.sliderImages[index], imageWidth: screenWidth)
                            .id(index)
                    }
                }
            }
            .padding(.top)
            .animation(.linear, value: sliderImagesViewModel.sliderImages)
            .onReceive(timer) { _ in
                currentIndex = currentIndex < sliderImagesViewModel.sliderImages.count - 1 ? currentIndex + 1 : 0
                withAnimation {
                    scrollProxy.scrollTo(currentIndex)
                }
            }
        }
    }
}

struct ImageView: View {
    let sliderImages: SliderImage
    let imageWidth: CGFloat
    var body: some View {
        Image(uiImage: sliderImages.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageWidth, height: 200)
    }
}
