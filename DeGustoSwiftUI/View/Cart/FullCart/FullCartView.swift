//
//  FullCartView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct FullCartView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                defaultCell
                Spacer()
                bottomView
                Button(action: {
                    print("Go to the menu")
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("darkRed").opacity(0.8))
                            .frame(width: geometry.size.width, height: 50)
                        Text("Оформити замовлення")
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct FullCartView_Previews: PreviewProvider {
    static var previews: some View {
        FullCartView()
    }
}

extension FullCartView {
    var bottomView: some View {
        VStack {
            Button(action: {
                print("Go to the menu")
            }) {
                Text("Видалити все")
                    .font(.title2)
            }
            .foregroundColor(Color("darkRed"))
            .padding(.bottom)
            
            HStack {
                Text("Всього на суму: ")
                    .font(.title2)
                Spacer()
                Text("100 uah")
                    .fontWeight(.bold)
                    .font(.title2)
            }.padding([.leading, .bottom, .trailing])
        }
    }
    
    var defaultCell: some View {
        ScrollView {
            LazyVStack {
                ForEach(0 ... 3, id: \.self) {_ in
                    cell
                    Divider()
                }
            }
        }
    }
    
    var cell: some View {
        HStack {
            Image("facebook")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: 100, height: 100, alignment: .leading)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text("Dish Title")
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
                HStack {
                    Button(action: {
                        print("minus")
                    }) {
                        Image(systemName: "minus")
                    }
                    .padding(.trailing)
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(Color("darkRed"))
                    .font(Font.system(.body).bold())
                    
                    Text("20")
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(Color("darkGreen"))
                    
                    Button(action: {
                        print("plus")
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.horizontal)
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(Color("darkRed"))
                    .font(Font.system(.body).bold())
                    Spacer()
                    Text("100 uah")
                        .font(.title2)
                }
            }
            Spacer()
        }.padding()
    }
}
