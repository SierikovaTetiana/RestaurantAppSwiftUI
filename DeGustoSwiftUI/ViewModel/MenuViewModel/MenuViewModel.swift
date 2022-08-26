//
//  MainViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 02.08.2022.
//

import Foundation
import Firebase

@MainActor final class MenuViewModel: ObservableObject {
    
    @Published var menu = [SectionData]()
    @Published var isLoading = false
    let faveSection = "Улюблене"
    
    func fetchMenu(completion: @escaping () -> ()) {
        isLoading = true
        Database.database().reference().child(FirebaseKeys.menu).observe(.value, with: { snapshot in
            if !snapshot.exists() { return }
            guard let menuDict : Dictionary = snapshot.value as? Dictionary<String,Any> else { return }
            for (key, value) in menuDict {
                let sectionDishTitleKey = key
                guard let sectionDict : Dictionary = value as? Dictionary<String,Any> else { return }
                var imageName = ""
                var order = 0
                var dishData = [DishData]()
                for (key, value) in sectionDict {
                    if key == FirebaseKeys.sectionImgName {
                        imageName = value as? String ?? ""
                    } else if key == FirebaseKeys.order {
                        order = value as? Int ?? 0
                    } else {
                        guard let dishDict : Dictionary = value as? Dictionary<String,Any> else { return }
                        guard let weight = dishDict[FirebaseKeys.weight] as? Int else { return }
                        guard let description = dishDict[FirebaseKeys.description] as? String else { return }
                        guard let price = dishDict[FirebaseKeys.price] as? Int else { return }
                        guard let dishImageName = dishDict[FirebaseKeys.dishImageName] as? String else { return }
                        dishData.append(DishData(id: UUID(), dishTitle: key, dishImgName: dishImageName, description: description, weight: weight, price: price))
                        dishData = dishData.sorted(by: { $0.dishTitle < $1.dishTitle })
                    }
                }
                self.isLoading = false
                self.menu.append(SectionData(id: UUID(), open: false, data: dishData, title: "\(sectionDishTitleKey)", sectionImgName: imageName, sectionImage: nil, order: order))
                self.menu = self.menu.sorted(by: { $0.order < $1.order })
            }
            completion()
        })
    }
    
    func fetchSectionMenuImage() {
        for index in menu.indices {
            let storageRef = Storage.storage().reference().child(FirebaseKeys.sectionImages).child("\(menu[index].sectionImgName).jpg")
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
    
    func fetchDishImages(indexOfSectionToFetch: Int?) {
        var sectionTitle = ""
        guard let sectionIndex = indexOfSectionToFetch else { return }
        for index in menu[sectionIndex].data.indices {
            if menu[sectionIndex].title != faveSection {
                sectionTitle = menu[sectionIndex].title
            } else {
                sectionTitle = menu[sectionIndex].data[index].parentSectionTitleForFave ?? ""
            }
            let storageRef = Storage.storage().reference().child(FirebaseKeys.menuImages).child(sectionTitle).child("\(menu[sectionIndex].data[index].dishImgName).jpg")
            storageRef.getData(maxSize: 1 * 480 * 480) { data, error in
                if let error = error {
                    print("Error fetchDishImages", error)
                } else {
                    guard let imgData = data else { return }
                    guard let image = UIImage(data: imgData) else { return }
                    self.menu[sectionIndex].data[index].dishImage = image
                }
            }
        }
    }
}
