//
//  MenuTableView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 04.08.2022.
//

import SwiftUI

struct MenuTableView: View {
    
    @ObservedObject var mainViewModel: MenuViewModel
    @ObservedObject var cartViewModel: CartViewModel
    @State private var expanded: Set<String> = []
    
    var body: some View {
        List (mainViewModel.menu) { item in
            DisclosureGroup(
                isExpanded: Binding<Bool> (
                    get: { expanded.contains(item.title) },
                    set: { isExpanding in
                        if isExpanding {
                            expanded.insert(item.title)
                            mainViewModel.fetchDishImages(indexOfSectionToFetch: mainViewModel.menu.firstIndex(of: item))
                        } else {
                            expanded.remove(item.title)
                        }
                    }
                ),
                content: {
                    subView(item: item)
                },
                label: {
                    HStack {
                        Image(uiImage: (item.sectionImage ?? UIImage(systemName: "leaf"))!)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                        
                        Text(item.title)
                            .font(.system(.title3, design: .rounded))
                            .bold()
                            .padding(.leading)
                    }
                }
            )
        }
        .frame(height: 1000)
        .accentColor(Color("darkGreen"))
        .environment(\.defaultMinListRowHeight, 80)
        .listStyle(.plain)
        .animation(.default, value: mainViewModel.menu)
    }
    
    func subView(item: SectionData) -> some View {
        return VStack {
            ForEach(item.data, id: \.self) { dish in
                if dish.dishImage != nil {
                    Image(uiImage: (dish.dishImage!))
                        .resizable()
                        .scaledToFit()
                        .overlay(
                            ZStack {
                                FaveButton(mainViewModel: mainViewModel, dish: dish, sectionIndex: mainViewModel.menu.firstIndex(of: item))
                            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        )
                }
                Text(dish.dishTitle)
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .foregroundColor(Color("darkGreen"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                Text(dish.description)
                    .font(.system(.title2, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(dish.weight) гр.")
                    .font(.system(.title3, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("darkGreen"))
                    .padding(.bottom)
                HStack {
                    Text("\(dish.price) грн.")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(Color("darkGreen"))
                    CartButton(cartViewModel: cartViewModel, mainViewModel: mainViewModel, dish: dish, price: dish.price)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

