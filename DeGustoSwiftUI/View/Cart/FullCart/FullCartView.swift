//
//  FullCartView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct FullCartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                defaultCell
                Spacer()
                bottomView
                NavigationLink {
                    CheckOutView()
                } label: {
                    Text("Оформити замовлення")
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: 50)
                        .background(Color("darkRed").opacity(0.8))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backNavButton)
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
        }.padding(.top)
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
    
    var backNavButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("darkGreen"))
                Text("Назад")
                    .foregroundColor(Color("darkGreen"))
            }
        }
    }
}
