import Foundation

enum Continent: String, CaseIterable, Decodable, Identifiable {
    case all
    case africa = "AF"
    case antarctica = "AN"
    case asia = "AS"
    case europe = "EU"
    case north_america = "NA"
    case oceania = "OC"
    case south_america = "SA"

    var id: Continent {
        self
    }

    var name: String {
        switch self {
        case .all:
            "All"
        case .africa:
            "Africa"
        case .antarctica:
            "Antarctica"
        case .asia:
            "Asia"
        case .europe:
            "Europe"
        case .north_america:
            "North America"
        case .oceania:
            "Oceania"
        case .south_america:
            "South America"
        }
    }

    static func getContinentName(for str: String?) -> String {
        guard let str = str else {
            return "Unknown Continent Name"
        }

        switch str {
        case africa.rawValue:
            return africa.name
        case antarctica.rawValue:
            return antarctica.name
        case asia.rawValue:
            return asia.name
        case europe.rawValue:
            return europe.name
        case north_america.rawValue:
            return north_america.name
        case oceania.rawValue:
            return oceania.name
        case south_america.rawValue:
            return south_america.name
        default:
            return "Continent"
        }
    }
}
