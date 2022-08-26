//
//  FaveButtonViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 05.08.2022.
//

import Foundation
import Firebase

extension MenuViewModel {
    
    func fetchUserFavorites(completion: @escaping () -> ()) {
        //remove fave section when user loged out
        if menu[0].title == faveSection {
            menu.remove(at: 0)
        }
        
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid)
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else { return }
            guard let firstData = document.data() else { return }
            if let favorites = firstData[FirebaseKeys.favorites] as? Array<String> {
                for item in favorites {
                    for index in self.menu.indices {
                        if let indexOfDish = self.menu[index].data.firstIndex(where: { $0.dishTitle == item }) {
                            self.menu[index].data[indexOfDish].favorite = true
                            self.menu[index].data[indexOfDish].parentSectionTitleForFave = self.menu[index].title
                            self.addDishToFaveSection(sectionIndex: index, dishIndex: indexOfDish)
                        }
                    }
                    self.menu = self.menu.sorted(by: { $0.order < $1.order })
                }
            }
            completion()
        }
    }
    
    func faveButtonTapped(sectionIndex: Int, dishIndex: Int?) {
        guard let dishIndex = dishIndex else { return }
        menu[sectionIndex].data[dishIndex].favorite = !menu[sectionIndex].data[dishIndex].favorite //change fave in menu section
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let docRef = Firestore.firestore().collection(FirebaseKeys.collectionUsers).document(userUid)
        docRef.getDocument { (document, error) in
            if self.menu[sectionIndex].data[dishIndex].favorite {
                docRef.updateData(([FirebaseKeys.favorites: FieldValue.arrayUnion([self.menu[sectionIndex].data[dishIndex].dishTitle])]), completion: nil)
                self.addDishToFaveSection(sectionIndex: sectionIndex, dishIndex: dishIndex)
                self.menu = self.menu.sorted(by: { $0.order < $1.order })
            } else {
                docRef.updateData(([FirebaseKeys.favorites: FieldValue.arrayRemove([self.menu[sectionIndex].data[dishIndex].dishTitle])]), completion: nil)
                self.removeDishFromFaveSection(sectionIndex: sectionIndex, dishIndex: dishIndex)
            }
        }
    }
    
    func addDishToFaveSection(sectionIndex: Int, dishIndex: Int) {
        if menu[0].title == faveSection { // if there are dishes in fave section
            menu[0].data.append(menu[sectionIndex].data[dishIndex])
        } else { // if dish to add will be the first dish in the section
            menu.append(SectionData(id: UUID(), open: false, data: [menu[sectionIndex].data[dishIndex]], title: faveSection, sectionImgName: "heart.circle", sectionImage: UIImage(systemName: "heart.circle"), order: 0))
        }
    }
    
    func removeDishFromFaveSection(sectionIndex: Int, dishIndex: Int) {
        toogleToFalseFavoriteInMenu(sectionIndex: sectionIndex, dishIndex: dishIndex)
        if menu[0].title == faveSection && menu[0].data.count == 1 {
            menu.removeAll(where: { $0.title == faveSection })
            menu = self.menu.sorted(by: { $0.order < $1.order })
            // if there are dishes besides dish to delete
        } else if menu[0].title == faveSection {
            menu[0].data.removeAll(where: { $0.dishTitle == menu[sectionIndex].data[dishIndex].dishTitle })
        }
    }
    
    func toogleToFalseFavoriteInMenu(sectionIndex: Int, dishIndex: Int) {
        let dishData = menu[sectionIndex].data[dishIndex]
        for index in menu.indices {
            if let indexOfDish = menu[index].data.firstIndex(where: { $0.dishTitle == dishData.dishTitle }) {
                menu[index].data[indexOfDish].favorite = false
            }
        }
    }
}

