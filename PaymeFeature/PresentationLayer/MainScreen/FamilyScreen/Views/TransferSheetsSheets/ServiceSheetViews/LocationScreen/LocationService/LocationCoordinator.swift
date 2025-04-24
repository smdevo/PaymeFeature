//
//  LocationCoordinator.swift
//  PaymeFeature
//
//  Created by Umidjon on 22/04/25.
//

import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: LocationMapView
    var currentCircle: MKCircle?
    weak var mapView: MKMapView?

    init(_ parent: LocationMapView) {
        self.parent = parent
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let mapView = sender.view as? MKMapView else { return }
        let point = sender.location(in: mapView)
        let tappedCoord = mapView.convert(point, toCoordinateFrom: mapView)

        parent.circleCenter = tappedCoord

        let centerLocation = CLLocation(latitude: parent.circleCenter.latitude, longitude: parent.circleCenter.longitude)
        let tappedLocation = CLLocation(latitude: tappedCoord.latitude, longitude: tappedCoord.longitude)
        let distance = centerLocation.distance(from: tappedLocation)

        if distance <= parent.radius {
            parent.selectedCoordinate = tappedCoord
        } else {
            parent.showAlert = true
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.fillColor = UIColor.systemRed.withAlphaComponent(0.2)
            renderer.strokeColor = .red
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
}

