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
    @State private var showMainView = false
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
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
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $showMainView, content: {
            MainView()
        })
        .overlay(
            ZStack {
                if isLoading {
                    GlassBackGround(color: .black)
                        .ignoresSafeArea(.all)
                    GrowingArcIndicatorView(color: Color(hex: AppUserInterface.Colors.gradientColor1), lineWidth: 2)
                        .frame(width: 50)
                }
            }
        )
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
        .alert(item: $alertItem) { item in
            Alert(
                title: Text(item.title),
                message: Text(item.message),
                dismissButton: .default(Text("OK"))
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
            Task {
                await sendLocationData()
            }
        case .none:
            print("Unknown location authorization status.")
        @unknown default:
            print("Unknown location authorization status.")
        }
    }
    
    private func sendLocationData() async {
        if let location = locationManagerDelegate.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let formattedLatitude = Double(String(format: "%.4f", latitude))!
            let formattedLongitude = Double(String(format: "%.4f", longitude))!
            
            DispatchQueue.main.async {
                isLoading = true
            }
            
            do {
                let updatedProfile = CleanersModel(longitude: formattedLongitude, latitude: formattedLatitude)
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let response = try await supabaseClient.supabase
                    .from("cleaners")
                    .update(updatedProfile)
                    .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                    .execute()
                
                DispatchQueue.main.async {
                    isLoading = false
                    if response.status == 200 {
                        showMainView = true
                    } else {
                        showAlert(title: "Update Failed", message: "Failed to update location. Please try again.")
                        print("Failed to update location. Status code: \(response.status)")
                    }
                }
                
                print(response.status)
                print(response.data)
                print(response.response.statusCode)
            } catch {
                DispatchQueue.main.async {
                    isLoading = false
                    showAlert(title: "Error", message: "Failed to update location: \(error.localizedDescription)")
                    print("Failed to update location: \(error.localizedDescription)")
                }
            }
        } else {
            DispatchQueue.main.async {
                isLoading = false
                showAlert(title: "Location Unavailable", message: "Unable to access your location. Please ensure location services are enabled and try again.")
                print("Location data is not available")
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        alertItem = AlertItem(title: title, message: message)
    }
}
#Preview {
    AddLocationView()
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}
