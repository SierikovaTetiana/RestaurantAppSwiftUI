//
//  MapViewModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 10.08.2022.
//

import SwiftUI
import MapKit

@MainActor final class MapViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.015519693946075, longitude: 36.22190427116375),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var markers = [MapModel(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: 50.015519693946075, longitude: 36.22190427116375), tint: .red))]
    
}
