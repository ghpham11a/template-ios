//
//  MapScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/23/24.
//

import CoreLocation
import MapKit
import SwiftUI


class IdentifiablePointAnnotation: MKPointAnnotation, Identifiable {
    let id = UUID()
}

struct MapScreen: View {
    
    @StateObject var locationManager = LocationManager()
    @Binding var path: NavigationPath
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130), // Example coordinates (San Francisco)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State var annotations: [IdentifiablePointAnnotation] = [
        IdentifiablePointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130), title: "San Francisco", subtitle: "California"),
        IdentifiablePointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), title: "Los Angeles", subtitle: "California")
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: annotations, annotationContent: { marker in
            MapPin(coordinate: marker.coordinate)
        })
            .onAppear {
                if let userLocation = locationManager.location {
                    region.center = userLocation.coordinate
                }
            }
            .edgesIgnoringSafeArea(.all)
    }
}
