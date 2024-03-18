import Foundation

class Airports {
    var allAirports: [Airport]
    var displayedAirports: [Airport]

    init() {
        let airports: [Airport] = Bundle.main.decode("airports-SML.json")
        allAirports = airports
        displayedAirports = airports
    }

    func filter(by continent: Continent) {
        if continent == .all {
            displayedAirports = allAirports
        } else {
            displayedAirports = allAirports.filter { airport in
                airport.continent == continent.rawValue
            }
        }
    }

    func search(for searchTerm: String) -> [Airport] {
        if searchTerm.isEmpty {
            return displayedAirports
        } else {
            return displayedAirports.filter { airport in
                airport.name.lowercased().hasPrefix(searchTerm.lowercased()) || airport.municipality.lowercased().hasPrefix(searchTerm.lowercased())
            }
        }
    }
}
