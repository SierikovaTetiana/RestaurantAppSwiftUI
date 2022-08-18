//
//  MapView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 02.08.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var mapViewModel = MapViewModel()
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var userAutorization: UserAutorization
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true,
                    annotationItems: mapViewModel.markers) { marker in
                    marker.location
                }
                Text("📍Місто Харків. Вулиця Космічна, 16. ☎️")
                    .padding(.top)
            }
            .padding(.vertical)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("logo").resizable().aspectRatio(contentMode: .fit)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    NavigationLink {
                        if userAutorization.isAnonymous {
                            LoginView(tabSelection: $tabSelection)
                        } else {
                            ProfileView(tabSelection: $tabSelection)
                        }
                    } label: {
                        Image(systemName: "person")
                            .imageScale(.large)
                            .foregroundColor(Color("darkGreen"))
                    },
                trailing:
                    NavigationLink {
                        if cartViewModel.cartDishData.isEmpty {
                            EmptyCartView(tabSelection: $tabSelection)
                        } else {
                            FullCartView()
                        }
                    } label: {
                        Image(systemName: "cart")
                            .foregroundColor(Color("darkGreen"))
                            .imageScale(.large)
                    })
        }.accentColor(Color("darkGreen"))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(tabSelection: .constant(2))
    }
}
