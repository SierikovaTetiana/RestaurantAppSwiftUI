//
//  EmptyCartView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct EmptyCartView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                logoView
                messageView
                Spacer()
                Button(action: {
                    print("Go to the menu")
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.8))
                            .frame(width: geometry.size.width, height: 50)
                        Text("Перейти у меню")
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct EmptyCartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartView()
            .previewInterfaceOrientation(.portrait)
    }
}

extension EmptyCartView {
    var logoView: some View {
        Image("logo")
            .padding(.bottom)
    }
    
    var messageView: some View {
        VStack {
            Text("Ваш кошик порожній :(")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.bottom)
            Text("Додайте ваші перші товари у кошик")
                .font(.title2)
                .foregroundColor(Color.gray)
        }
    }
}
