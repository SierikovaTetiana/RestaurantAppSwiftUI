//
//  MyAlert.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 23.08.2022.
//

import SwiftUI

struct MyAlert: View {
    @State private var text: String = ""

    var body: some View {

        VStack {
            Text("Enter Input").font(.headline).padding()
            
            TextField("Type text here", text: $text)
            .textFieldStyle(.roundedBorder).padding()
            Divider()
            HStack {
                Spacer()
                Button(action: {
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                }) {

                    Text("Done")
                }
                Spacer()

                Divider()

                Spacer()
                Button(action: {
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                }) {
                    Text("Cancel")
                }
                Spacer()
            }.padding(0)


            }.background(Color(white: 0.9))
    }
}
