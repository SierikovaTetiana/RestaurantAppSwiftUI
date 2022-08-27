//
//  FullCartView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct FullCartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                cell
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
            .alert(isPresented: $cartViewModel.isPresentingAlertError, content: {
                Alert(
                    title: Text("Сталася помилка"),
                    message: Text(cartViewModel.errorDescription),
                    dismissButton: .default(Text("Добре"))
                )
            })
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
                cartViewModel.removeAllDishesFromCart()
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
                Text("\(cartViewModel.totalCart.totalPrice) грн.")
                    .fontWeight(.bold)
                    .font(.title2)
            }.padding([.leading, .bottom, .trailing])
        }.animation(Animation.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: UUID())
    }
    
    var cell: some View {
        List (cartViewModel.cartDishData, id: \.id) { item in
            Section {
                HStack {
                    Image(uiImage: (item.dishImage ?? UIImage(systemName: "leaf"))!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 100, height: 100, alignment: .leading)
                        .padding(.trailing)
                    VStack(alignment: .leading) {
                        Text(item.dishTitle)
                            .font(.title2)
                            .fontWeight(.medium)
                        Spacer()
                        HStack {
                            Button(action: {
                                cartViewModel.addChangesToCountDishFromCart(dish: item, addDish: false)
                            }) {
                                Image(systemName: "minus")
                            }
                            .padding(.trailing)
                            .buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(Color("darkRed"))
                            .font(Font.system(.body).bold())
                            
                            Text("\(item.count)")
                                .font(.system(.title3, design: .rounded))
                                .foregroundColor(Color("darkGreen"))
                            
                            Button(action: {
                                cartViewModel.addChangesToCountDishFromCart(dish: item, addDish: true)
                            }) {
                                Image(systemName: "plus")
                            }
                            .padding(.horizontal)
                            .buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(Color("darkRed"))
                            .font(Font.system(.body).bold())
                            Spacer()
                            Text("\(item.priceOfDishes) грн.")
                                .font(.title2)
                        }
                    }
                }
            }
        }.animation(Animation.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: UUID())
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
