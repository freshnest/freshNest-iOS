//
//  MapView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var annotation = MKPointAnnotation()

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow)) // Shows the user's location
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Set the initial location for the annotation
                annotation.coordinate = CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)
            }
            .onReceive(Just(region.center)) { // Update annotation's coordinate when region changes
                annotation.coordinate = $0
            }
            .overlay(
                GeometryReader { geo in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                }
            )
    }
}


struct NonInteractiveMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var annotation = MKPointAnnotation()

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow)) // Shows the user's location
            .edgesIgnoringSafeArea(.all)
//            .overlay(
//                CircleOverlay(coordinate: region.center, radius: 1 * 1609.34)
//            )
            .onAppear {
                // Set the initial location for the annotation
                annotation.coordinate = CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)
            }
            .onReceive(Just(region.center)) { // Update annotation's coordinate when region changes
                annotation.coordinate = $0
            }
            .overlay(
                GeometryReader { geo in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                }
            )
            .gesture(DragGesture().onChanged{_ in})
    }
}
