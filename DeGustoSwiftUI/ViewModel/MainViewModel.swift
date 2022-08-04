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
                    self.menu = self.menu.sorted(by: { $0.order < $1.order })
                }
            }
            completion()
        })
    }o
    
    func fetchSectionMenuImage() {
        for index in menu.indices {
            let storageRef = Storage.storage().reference().child("sectionImages").child("\(menu[index].sectionImgName).jpg")
            storageRef.getData(maxSize: 1 * 480 * 480) { data, error in
                if let error = error {
                    print("Error fetchSectionMenuImage", error)
                } else {
                    guard let imgData = data else { return }
                    guard let image = UIImage(data: imgData) else { return }
                    self.menu[index].sectionImage = image
                }
            }
        }
    }
}
