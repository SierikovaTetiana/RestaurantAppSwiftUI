//
//  FetchMenuViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 03.08.2022.
//

import Foundation
import Firebase

@MainActor final class SliderImagesViewModel: ObservableObject {
    
    @Published var sliderImages = [SliderImage]()
    
    func fetchSliderImages() {
        let storageReference = Storage.storage().reference().child("sliderImages")
        storageReference.listAll { (result, error) in
            if let error = error {
                print("Error fetchSliderImages listAll: ", error)
            }
            guard let result = result else { return }
            for item in result.items {
                let storageRef = Storage.storage().reference().child("sliderImages/\(item.name)")
                storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Error fetchSliderImages getData", error)
                    } else {
                        guard let imgData = data else { return }
                        guard let image = UIImage(data: imgData) else { return }
                        DispatchQueue.main.async {
                            self.sliderImages.append(SliderImage(image: image))
                        }
                    }
                }
            }
        }
    }
}
