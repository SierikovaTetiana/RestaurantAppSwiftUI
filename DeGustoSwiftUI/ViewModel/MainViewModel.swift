//
//  MainViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 02.08.2022.
//

import Foundation
import Firebase

class MainViewModel: ObservableObject {
    
    @Published var menu = [SectionData]()
    
    func fetchMenu(completion: @escaping () -> ()) {
        Database.database().reference().child("menu").observe(.value, with: { snapshot in
            if !snapshot.exists() { return }
            if let menuDict : Dictionary = snapshot.value as? Dictionary<String,Any> {
                for (key, value) in menuDict {
                    let sectionDishTitleKey = key
                    guard let dishDict : Dictionary = value as? Dictionary<String,Any> else { return }
                    var imageName = ""
                    var order = 0
                    for (key, value) in dishDict {
                        if key == "sectionImgName" {
                            imageName = value as? String ?? ""
                        }
                        if key == "order" {
                            order = value as? Int ?? 0
                        }
                    }
                    self.menu.append(SectionData(id: UUID(), open: false, title: "\(sectionDishTitleKey)", sectionImgName: imageName, sectionImage: nil, order: order))
                }
            }
            completion()
        })
    }
    
    func fetchSectionMenuImage() {
        for item in menu {
            let storageRef = Storage.storage().reference().child("sectionImages").child("\(item.sectionImgName).jpg")
            storageRef.getData(maxSize: 1 * 480 * 480) { data, error in
                if let error = error {
                    print("Error fetchSectionMenuImage", error)
                } else {
                    guard let imgData = data else { return }
                    guard let image = UIImage(data: imgData) else { return }
                    item.sectionImage = image
                }
            }
        }
    }
}
