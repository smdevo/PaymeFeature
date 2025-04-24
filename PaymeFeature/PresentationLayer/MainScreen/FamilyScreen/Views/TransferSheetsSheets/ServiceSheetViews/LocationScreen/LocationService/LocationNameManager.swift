//
//  LocationNameManager.swift
//  PaymeFeature
//
//  Created by Umidjon on 22/04/25.
//


import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}


class LocationNameManager: NSObject, ObservableObject {
    private let geocoder = CLGeocoder()
    
    @Published var placeName: String = ""
    
    func getName(from coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let placemark = placemarks?.first {
                let name = [
                    placemark.name,
                    placemark.locality
                ].compactMap { $0 }.joined(separator: ", ")
                
                DispatchQueue.main.async {
                    self?.placeName = name
                }
            } else {
                DispatchQueue.main.async {
                    self?.placeName = "Неизвестное место"
                }
            }
        }
    }
}

