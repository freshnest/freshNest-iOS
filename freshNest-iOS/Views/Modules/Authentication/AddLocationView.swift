//
//  AddLocationView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 13/06/24.
//

import SwiftUI
import CoreLocation

struct AddLocationView: View {
    @State private var phoneNumber = ""
    @StateObject private var locationManagerDelegate = LocationManagerDelegate.shared
    @State private var locationStatus: CLAuthorizationStatus?
    @State private var showLocationPermissionAlert = false
    @State private var sendLocationData = false
    @State private var showMainView = false
    @EnvironmentObject var supabaseClient: SupabaseManager
    var body: some View {
        VStack(alignment: .leading) {
            BackButton()
            VStack(alignment: .leading, spacing: 16) {
                Text("Please provide location access.")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                
                Text("We need your location permission to dectect nearby available jobs for you.")
                    .font(.cascaded(ofSize: .h16, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                Image("location")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 360)
                    .padding(.vertical, 32)
            }
            .padding(.top, 40)
            Spacer()
            VStack(spacing: 16) {
                RoundedButton(title: "Give Location Permission", action: {
                    checkLocationPermission()
                    if sendLocationData {
                        if let location = locationManagerDelegate.location {
                            let latitude = location.coordinate.latitude
                            let longitude = location.coordinate.longitude
                            let formattedLatitude = Double(String(format: "%.4f", latitude))!
                            let formattedLongitude = Double(String(format: "%.4f", longitude))!
                            Task {
                                do {
                                    let updatedProfile = CleanersModel(longitude: longitude, latitude: latitude)
                                    let currentUser = try await supabaseClient.supabase.auth.session.user
                                    let response = try await supabaseClient.supabase
                                        .from("cleaners")
                                        .update(updatedProfile)
                                        .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                                        .execute()
                                    
                                    if response.status == 200 {
                                        showMainView.toggle()
                                    }
                                    print(response.status)
                                    print(response.data)
                                    print(response.response.statusCode)
                                } catch {
                                    print("Failed to update location: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $showMainView, content: {
            MainView()
        })
        .alert(isPresented: $showLocationPermissionAlert) {
            Alert(
                title: Text("📍Location Required"),
                message: Text("We need your location to show available jobs near you. \nYou can enable location permission from the settings."),
                dismissButton: .default(Text("Open Location Permission").fontWeight(.bold)) {
                    showLocationPermissionAlert = false
                    print("Alert Status: \(showLocationPermissionAlert)")
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
            )
        }
    }
    private func checkLocationPermission() {
        locationManagerDelegate.locationManager.delegate = locationManagerDelegate
        locationStatus = locationManagerDelegate.locationManager.authorizationStatus
        
        switch locationStatus {
        case .notDetermined:
            DispatchQueue.main.async {
                locationManagerDelegate.locationManager.requestWhenInUseAuthorization()
            }
        case .restricted, .denied:
            print("Location access is restricted or denied.")
            showLocationPermissionAlert = true
            print("Alert Status: \(showLocationPermissionAlert)")
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access is granted.")
            sendLocationData = true
        @unknown default:
            print("Unknown location authorization status.")
        }
    }
}
#Preview {
    AddLocationView()
}

