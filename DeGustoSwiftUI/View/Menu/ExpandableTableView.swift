//
//  ExpandableTableView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 03.08.2022.
//

import SwiftUI

struct ExpandableTableView: View {

    @ObservedObject var mainViewModel: MainViewModel
    
var body: some View {
    List {
        ForEach(mainViewModel.menu) { item in
            HStack {
                Image(uiImage: (item.sectionImage ?? UIImage(systemName: "person"))!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                
                Text(item.title)
                    .font(.system(.title3, design: .rounded))
                    .bold()
            }
        }
    }
    .listStyle(.plain)
}
}
