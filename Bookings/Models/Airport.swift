import MapKit
import SwiftUI

struct Airport: Codable, Equatable, Identifiable, Hashable {
    let id: Int
    let ident: String?
    let type: String
    let name: String
    let latitude_deg: String
    let longitude_deg: String
    let elevation_ft: Int?
    let continent: String?
    let iso_country: String?
    let iso_region: String?
    let municipality: String
    let scheduled_service: String?
    let gps_code: String?
    let iata_code: String
    let local_code: String?
    let home_link: String?
    let wikipedia_link: String?

    static func == (lhs: Airport, rhs: Airport) -> Bool {
        lhs.id == rhs.id
    }

    var coordinate: CLLocationCoordinate2D {
        let latitude: CLLocationDegrees = (latitude_deg as NSString).doubleValue
        let longitude: CLLocationDegrees = (longitude_deg as NSString).doubleValue

        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var continentFullName: String {
        Continent.getContinentName(for: continent)
    }

    var airportType: String {
        switch type {
        case "small_airport":
            "Small Airport"
        case "medium_airport":
            "Medium Airport"
        case "large_airport":
            "Large Airport"
        default:
            "Unknown Airport Type"
        }
    }
}
