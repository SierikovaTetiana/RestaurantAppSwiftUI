//
//  ProfileView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct ProfileView: View {
    @State var text = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                headerView
                Spacer()
                rowsView
                logOut
                Spacer()
                socialButtons
            }
            .navigationTitle("Профіль")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                // do something
            }) {
                Image(systemName: "cart")
                    .foregroundColor(Color("darkGreen"))
                    .imageScale(.large)
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    var headerView: some View {
        HStack {
            Text("Ви з нами вже 65 днів")
                .foregroundColor(Color("darkGreen"))
                .font(.title2)
            Spacer()
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 80, height: 80)
        }
        .padding([.leading, .bottom, .trailing])
    }
    
    var rowsView: some View {
        VStack(spacing: 20) {
            ForEach(ProfileViewModel.allCases, id: \.rawValue) { item in
                HStack {
                    Image(systemName: item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .leading)
                        .foregroundColor(Color("darkGreen"))
                    TextField("\(item.description)", text: $text)
                        .padding(.leading)
                    Image(systemName: "pencil")
                        .foregroundColor(Color("darkGreen"))
                }.padding(.horizontal)
                Divider()
            }
        }
        .padding(.bottom)
    }
    
    var logOut: some View {
        Button {
            print("pressed log out account")
        } label: {
            Text("Вийти з акаунту")
                .foregroundColor(Color("darkGreen"))
                .font(.title)
                .padding(.top)
        }
    }
    
    var socialButtons: some View {
        VStack {
            Text("Офіційні сторінки DeGusto")
                .foregroundColor(Color("darkGreen"))
                .font(.title3)
                .padding(.bottom)
            HStack(spacing: 30) {
                Button {
                    print("facebook")
                } label: {
                    Image("facebook")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60, alignment: .center)
                }
                
                Button {
                    print("site")
                } label: {
                    Image(systemName: "network")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("darkRed"))
                        .frame(height: 60, alignment: .center)
                }
                
                Button {
                    print("instagram")
                } label: {
                    Image("Inst")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60, alignment: .center)
                }
            }
        }
    }
}
