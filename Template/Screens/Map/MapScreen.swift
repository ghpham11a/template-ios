//
//  MapScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/23/24.
//

import Combine
import CoreLocation
import MapKit
import SwiftUI


class IdentifiablePointAnnotation: MKPointAnnotation, Identifiable {
    let id = UUID()
}

struct MapScreen: View {
    
    @StateObject var locationManager = LocationManager.shared
    
    @Binding var path: NavigationPath
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State var annotations: [IdentifiablePointAnnotation] = []
    
    @State var searchResults: [MKMapItem] = []
    @State var searchIsOpen: Bool = false
    @State var searchContent: String = ""
    @State var searchPlaceholder: String = "Search locations"
    
    var body: some View {
        VStack {
            HStack {
                
                if searchIsOpen {
                    ZStack {
                        TextField("", text: $searchContent)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .onChange(of: searchContent) { (old, new) in
                                DispatchQueue.main.async {
                                    self.search(for: new)
                                }
                            }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                searchContent = ""
                                searchPlaceholder = "Search locations"
                                clearLocations()
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8)
                        }
                        .padding(.trailing, 8)
                    }
                    .padding()
                    .navigationBarBackButtonHidden()
                    .navigationBarItems(leading: MapearchBackButton(isSearchOpen: $searchIsOpen, annotations: $annotations, searchContent: $searchContent, searchPlaceholder: $searchPlaceholder, searchResults: $searchResults))
                    
                } else {
                    Button(action: {
                        searchIsOpen.toggle()
                    }) {
                        HStack {
                            Text(searchPlaceholder)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                }
                
            }
            
            ZStack {
                
                
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: annotations, annotationContent: { marker in
                    MapPin(coordinate: marker.coordinate)
                })
                    .onAppear {
                        if let userLocation = locationManager.location {
                            region.center = userLocation.coordinate
                        }
                    }
                
                if searchIsOpen {
                    List {
                        ForEach(searchResults, id: \.hash) { todo in
                            Button(action: {
                                region = MKCoordinateRegion(
                                    center: todo.placemark.coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                )
                                annotations = [IdentifiablePointAnnotation(__coordinate: todo.placemark.coordinate, title: "", subtitle: "")]
                                searchPlaceholder = todo.placemark.title ?? ""
                                searchContent = todo.placemark.title ?? ""
                                searchIsOpen.toggle()
                            }) {
                                Text(todo.placemark.title ?? "NULL")
                            }
                            .padding()
                            
                        }
                    }
                }
            }
    
        }
    }
    
    private func clearLocations() {
        self.searchResults = []
    }
    
    private func setupDebouncer(for query: String) -> AnyCancellable {
        let publisher = Just(query)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { query in
                search(for: query)
            }
        return publisher
    }
    
    func search(for query: String) {
        
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.searchResults = response.mapItems
        }
    }
}

struct MapearchBackButton: View {
    
    @Binding var isSearchOpen: Bool
    @Binding var annotations: [IdentifiablePointAnnotation]
    @Binding var searchContent: String
    @Binding var searchPlaceholder: String
    @Binding var searchResults: [MKMapItem]
    
    // @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            if !annotations.isEmpty {
                searchContent = searchPlaceholder
            } else {
                searchContent = ""
                searchPlaceholder = "Search location"
                searchResults = []
            }
            isSearchOpen.toggle()
        }) {
            HStack {
                Image(systemName: "xmark")
            }
        }
    }
}
