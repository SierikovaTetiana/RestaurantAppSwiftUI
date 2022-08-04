//
//  MenuTableView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 04.08.2022.
//

import SwiftUI

struct MenuTableView: View {
    
    @ObservedObject var mainViewModel: MenuViewModel
//    @State private var expanded: Bool = false
    
    var body: some View {
        List (mainViewModel.menu) { item in
            DisclosureGroup(
//                isExpanded: $expanded,
                content: {
                    subView(item: item)
                },
                label: {
//                    Button(
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
//                    )  {
//                        withAnimation {
//                            expanded.toggle()
//                        }
//                      }
//                    HStack {
//                        Image(uiImage: (item.sectionImage ?? UIImage(systemName: "leaf"))!)
//                            .resizable()
//                            .scaledToFit()
//                            .clipShape(Circle())
//                            .frame(width: 50, height: 50)
//
//                        Text(item.title)
//                            .font(.system(.title3, design: .rounded))
//                            .bold()
//                            .padding(.leading)
//                    }
                }
            )
        }
        .accentColor(Color("darkGreen"))
        .environment(\.defaultMinListRowHeight, 80)
        .listStyle(.plain)
        .animation(.default, value: mainViewModel.menu)
    }
    
    func subView(item: SectionData) -> some View {
        return VStack {
            ForEach(item.data, id: \.self) { dish in
                Image(uiImage: (item.sectionImage ?? UIImage(systemName: "leaf"))!)
                    .resizable()
                    .scaledToFit()
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
                    //TODO: make Button, not text:
                    Text("У КОШИК")
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(Color("darkGreen"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

