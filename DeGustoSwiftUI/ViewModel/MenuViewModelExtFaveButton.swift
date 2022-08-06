//
//  FaveButtonViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 05.08.2022.
//

import Foundation
import Firebase

extension MenuViewModel {
    
    func fetchUserFavorites() {
        
    }
    
    func faveButtonTapped(sectionIndex: Int, dishIndex: Int?) {
        guard let dishIndex = dishIndex else { return }
        menu[sectionIndex].data[dishIndex].favorite = !menu[sectionIndex].data[dishIndex].favorite //change fave in menu section
        let userUid = UserAutorization.userAutorization.userUid
        let docRef = Firestore.firestore().collection("users").document(userUid)
        docRef.getDocument { (document, error) in
            if self.menu[sectionIndex].data[dishIndex].favorite {
                docRef.updateData((["favorites": FieldValue.arrayUnion([self.menu[sectionIndex].data[dishIndex].dishTitle])]), completion: nil)
                self.addDishToFaveSection(sectionIndex: sectionIndex, dishIndex: dishIndex)
            } else {
                docRef.updateData((["favorites": FieldValue.arrayRemove([self.menu[sectionIndex].data[dishIndex].dishTitle])]), completion: nil)
                self.removeDishFromFaveSection(sectionIndex: sectionIndex, dishIndex: dishIndex)
            }
        }
    }
    
    func addDishToFaveSection(sectionIndex: Int, dishIndex: Int) {
        if menu[0].title == "Улюблене" { // if there are dishes in fave section
            menu[0].data.append(menu[sectionIndex].data[dishIndex])
        } else { // if dish to add will be the first dish in the section
            menu.append(SectionData(id: UUID(), open: false, data: [self.menu[sectionIndex].data[dishIndex]], title: "Улюблене", sectionImgName: "heart", sectionImage: UIImage(systemName: "heart"), order: 0))
            menu = self.menu.sorted(by: { $0.order < $1.order })
        }
    }
    
    func removeDishFromFaveSection(sectionIndex: Int, dishIndex: Int) {
        if menu[0].title == "Улюблене" && menu[0].data.count == 1 {
            menu.removeAll(where: { $0.title == "Улюблене" })
            menu = self.menu.sorted(by: { $0.order < $1.order })
        // if there are dishes besides dish to delete
        } else if menu[0].title == "Улюблене" {
            menu[0].data.removeAll(where: { $0.dishTitle == menu[sectionIndex].data[dishIndex].dishTitle })
        }
        toogleToFalseFavoriteInMenu(sectionIndex: sectionIndex, dishIndex: dishIndex)
    }
    
    func toogleToFalseFavoriteInMenu(sectionIndex: Int, dishIndex: Int) {
        let dishData = menu[sectionIndex].data[dishIndex]
        for index in menu.indices {
            guard let indexOfDish = menu[index].data.firstIndex(where: { $0.dishTitle == dishData.dishTitle }) else { return }
            menu[index].data[indexOfDish].favorite = false
        }
    }
}

