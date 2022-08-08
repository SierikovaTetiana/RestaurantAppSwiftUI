//
//  MapView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 02.08.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.015519693946075, longitude: 36.22190427116375),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    let markers = [Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: 50.015519693946075, longitude: 36.22190427116375), tint: .red))]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true,
                annotationItems: markers) { marker in
                marker.location
            }
            Text("📍Місто Харків. Вулиця Космічна, 16. ☎️")
                .padding(.top)
        }
        .padding(.vertical)
    }
}

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}
