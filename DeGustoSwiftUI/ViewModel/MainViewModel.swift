//
//  MainViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 02.08.2022.
//

import Foundation
import Firebase

class MainViewModel: ObservableObject {
    
    @Published var test = ""
    @Published var sliderImages = [UIImage]()
    
    func fetchSliderImages() {
        print("test")
        let storageReference = Storage.storage().reference().child("sliderImages")
        storageReference.listAll { (result, error) in
            if let error = error {
                print("Error: ", error)
            }
            guard let result = result else { return }
            for item in result.items {
                let storageRef = Storage.storage().reference().child("sliderImages/\(item.name)")
                storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Uh-oh, an error occurred in CategoryRow func getImagesForSlider!", error)
                    } else {
                        if let imgData = data {
                            if let image = UIImage(data: imgData) {
                                DispatchQueue.main.async {
                                    self.sliderImages.append(image)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fetchMenu() {
        print("test")
        Database.database().reference().child("menu").observe(.value, with: { snapshot in
            if !snapshot.exists() { return }
            DispatchQueue.main.async {
                self.test = "Result"
            }
            //            print(snapshot.value)
        })
    }
}
