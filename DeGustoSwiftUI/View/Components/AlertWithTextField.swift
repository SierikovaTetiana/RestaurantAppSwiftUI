//
//  AlertControl.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 23.08.2022.
//

import SwiftUI

struct AlertWithTextField: UIViewControllerRepresentable {
    
    @Binding var textFromAlert: String
    @Binding var show: Bool
    @Binding var conformChanges: Bool
    
    var title: String
    var message: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWithTextField>) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: UIViewControllerRepresentableContext<AlertWithTextField>) {
        guard context.coordinator.alert == nil else { return }
        if self.show {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert
            
            alert.addTextField { textField in
                textField.text = self.textFromAlert
                textField.delegate = context.coordinator
            }
            alert.addAction(UIAlertAction(title: "Скасувати", style: .destructive) { _ in })
            alert.addAction(UIAlertAction(title: "Підтвердити", style: .default) { _ in
                conformChanges = true
            })
            
            DispatchQueue.main.async {
                viewController.present(alert, animated: true, completion: {
                    self.show = false
                    context.coordinator.alert = nil
                })
            }
        }
    }
    
    func makeCoordinator() -> AlertWithTextField.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        var control: AlertWithTextField
        init(_ control: AlertWithTextField) {
            self.control = control
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text as NSString? {
                self.control.textFromAlert = text.replacingCharacters(in: range, with: string)
            } else {
                self.control.textFromAlert = ""
            }
            return true
        }
    }
}
