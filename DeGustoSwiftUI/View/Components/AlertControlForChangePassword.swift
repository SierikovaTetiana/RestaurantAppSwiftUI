//
//  AlertControl.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 23.08.2022.
//

import SwiftUI

struct AlertControlForChangePassword: UIViewControllerRepresentable {

    @Binding var textFromAlert: String
    @Binding var placeholder: String
    @Binding var show: Bool

    var title: String
    var message: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControlForChangePassword>) -> UIViewController {
        return UIViewController()
    }

    func updateUIViewController(_ viewController: UIViewController, context: UIViewControllerRepresentableContext<AlertControlForChangePassword>) {
        guard context.coordinator.alert == nil else { return }
        if self.show {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert

            alert.addTextField { textField in
                textField.placeholder = placeholder
                textField.text = self.textFromAlert
                textField.delegate = context.coordinator
            }
            alert.addAction(UIAlertAction(title: "Скасувати", style: .destructive) { _ in })
            alert.addAction(UIAlertAction(title: "Підтвердити", style: .default) { _ in
                // your action here
            })

            DispatchQueue.main.async {
                viewController.present(alert, animated: true, completion: {
                    self.show = false
                    context.coordinator.alert = nil
                })
            }
        }
    }

    func makeCoordinator() -> AlertControlForChangePassword.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        var control: AlertControlForChangePassword
        init(_ control: AlertControlForChangePassword) {
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
