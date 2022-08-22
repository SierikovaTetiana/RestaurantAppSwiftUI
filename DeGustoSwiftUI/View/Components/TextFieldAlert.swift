//
//  TextFieldAlert.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 15.08.2022.
//

import SwiftUI

struct TextFieldAlert: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    @Binding var text: String
    let placeholder: String
    let action: (String) -> Void
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
                .disabled(isPresented)
            if isPresented {
                VStack {
                    Text(title).lineLimit(nil).font(.headline).fixedSize(horizontal: false, vertical: true).padding()
                    Text(message).lineLimit(nil).font(.callout).fixedSize(horizontal: false, vertical: true)
                    TextField(placeholder, text: $text).textFieldStyle(.roundedBorder).padding()
                    Divider()
                    HStack{
                        Spacer()
                        Button(role: .cancel) {
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Text("Скасувати")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        Button() {
                            action(text)
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Text("Підтвердити")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                }
                .background(.background)
                .frame(width: 300, height: 280)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.quaternary, lineWidth: 1)
                }
            }
        }
    }
}

extension View {
    public func textFieldAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        text: Binding<String>,
        placeholder: String = "",
        action: @escaping (String) -> Void
    ) -> some View {
        self.modifier(TextFieldAlert(isPresented: isPresented, title: title, message: message, text: text, placeholder: placeholder, action: action))
    }
}
