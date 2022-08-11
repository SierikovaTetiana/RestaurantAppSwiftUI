//
//  MapModel.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 10.08.2022.
//

import SwiftUI
import MapKit

struct MapModel: Identifiable {
    let id = UUID()
    var location: MapMarker
}
