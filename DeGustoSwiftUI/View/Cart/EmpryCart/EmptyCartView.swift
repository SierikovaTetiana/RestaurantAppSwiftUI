//
//  EmptyCartView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct EmptyCartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var tabSelection: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                logoView
                messageView
                Spacer()
                Button(action: {
                    self.tabSelection = 1
                }) {
                    Text("Перейти у меню")
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: 50)
                        .background(Color.gray.opacity(0.8))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backNavButton)
        }
    }
}

struct EmptyCartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartView(tabSelection: .constant(2))
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
    
    var backNavButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("darkGreen"))
                Text("Меню")
                    .foregroundColor(Color("darkGreen"))
            }
        }
    }
}
