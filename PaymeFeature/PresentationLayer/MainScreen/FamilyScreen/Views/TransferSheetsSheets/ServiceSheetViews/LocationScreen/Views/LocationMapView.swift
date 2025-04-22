//
//  LocationMapView.swift
//  PaymeFeature
//
//  Created by Umidjon on 22/04/25.
//

import SwiftUI
import MapKit

struct LocationMapView: UIViewRepresentable {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var showAlert: Bool
    @Binding var circleCenter: CLLocationCoordinate2D
    var radius: Double

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        context.coordinator.mapView = mapView

        let region = MKCoordinateRegion(
            center: circleCenter,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
        mapView.setRegion(region, animated: false)

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if let existingCircle = context.coordinator.currentCircle {
            mapView.removeOverlay(existingCircle)
        }

        let circle = MKCircle(center: circleCenter, radius: radius)
        context.coordinator.currentCircle = circle
        mapView.addOverlay(circle)
    }
}



#Preview {
    LocationPickerScreen(closure: {})
}
