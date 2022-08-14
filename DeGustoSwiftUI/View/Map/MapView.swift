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
    @StateObject var cartViewModel: CartViewModel
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
                        if UserAutorization.userAutorization.isAnonymous {
                            LoginView()
                        } else {
                            ProfileView(cartViewModel: cartViewModel, tabSelection: $tabSelection)
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
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(cartViewModel: CartViewModel(), tabSelection: .constant(2))
    }
}
