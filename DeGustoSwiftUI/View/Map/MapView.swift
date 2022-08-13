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
            .navigationBarItems(leading: Button(action: {
                // do something
            }) {
                Image(systemName: "person")
                    .imageScale(.large)
                    .foregroundColor(Color("darkGreen"))
            }, trailing: Button(action: {
                // do something
            }) {
                Image(systemName: "cart")
                    .foregroundColor(Color("darkGreen"))
                    .imageScale(.large)
            })
        }
    }
}
