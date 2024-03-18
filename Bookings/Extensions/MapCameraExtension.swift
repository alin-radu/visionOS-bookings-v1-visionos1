import MapKit
import SwiftUI

extension MapCamera {
    enum CameraPosition {
        case standard
        var id: CameraPosition {
            self
        }
    }

    static func getMapCameraPosition(coordinate: CLLocationCoordinate2D, cameraPosition: CameraPosition) -> MapCamera {
        switch cameraPosition {
        case .standard:
            return MapCamera(centerCoordinate: coordinate,
                             distance: 1000,
                             heading: 250,
                             pitch: 60)
        }
    }
}
