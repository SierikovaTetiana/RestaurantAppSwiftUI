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
        VStack {
            Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true,
                annotationItems: mapViewModel.markers) { marker in
                marker.location
            }
            Text("📍Місто Харків. Вулиця Космічна, 16. ☎️")
                .padding(.top)
        }
        .padding(.vertical)
    }
}
