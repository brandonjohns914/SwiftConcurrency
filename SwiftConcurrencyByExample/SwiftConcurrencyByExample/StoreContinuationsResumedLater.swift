//
//  StoreContinuationsResumedLater.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/27/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationContinuation: CheckedContinuation<CLLocationCoordinate2D?, Error>?
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() async throws -> CLLocationCoordinate2D? {
        try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationContinuation?.resume(returning: locations.first?.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationContinuation?.resume(throwing: error)
    }
}

struct StoreContinuationsResumedLater: View {
    @StateObject private var locationManager = LocationManager()

        var body: some View {
            LocationButton {
                Task {
                    if let location = try? await locationManager.requestLocation() {
                        print("Location: \(location)")
                    } else {
                        print("Location unknown.")
                    }
                }
            }
            .frame(height: 44)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()
        }
}

#Preview {
    StoreContinuationsResumedLater()
}
