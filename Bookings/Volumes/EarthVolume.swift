import MapKit
import RealityKit
import RealityKitContent
import SwiftUI

import SwiftUI

struct TopAirports {
    let airports: Airports = Airports()

    var selectedAirports: [Airport] {
        let LA_GUARDIA_AIRPORT_USA: Airport = airports.getAirportById(airportId: 3643)
        let DALY_RIVER_AIRPORT_AUSTRALIA = airports.getAirportById(airportId: 3878)
        let SIBIU_INTERBATIONAL_AIRPORT_ROMANIA = airports.getAirportById(airportId: 4483)

        print("airport ---> airport name", LA_GUARDIA_AIRPORT_USA.name)
        return [LA_GUARDIA_AIRPORT_USA, DALY_RIVER_AIRPORT_AUSTRALIA, SIBIU_INTERBATIONAL_AIRPORT_ROMANIA]
    }
}

struct EarthVolume: View {
    /// The Earth entity that the view creates and stores for later updates.
    @State private var earth: Entity?
    @State private var favoritePlaces: [Airport] = TopAirports().selectedAirports

    // 0.10249999
    // 0.20499998
    let earthRadius: Float = 0.10249999

    var body: some View {
        ZStack {
            RealityView { content, _ in
                print("---> EarthVolume | RealityView | starting to load the Earth entity")

                // Load the entity model.
                guard let earthEntity = await RealityKitContent.entity(named: "EarthScene") else {
                    print("---> EarthVolume | RealityView | Something went wrong with loading the Earth entity")
                    return
                }

                let boundingBox = earthEntity.visualBounds(relativeTo: nil)
                let radius = boundingBox.extents.x / 2

                print("radius -------> ", radius)

                // Changing the size of the entity.
                // earthEntity.transform.scale = [2.5, 2.5, 2.5]

                // print("---> EarthVolume | RealityView | conten | add entity to content")
                // add entity to the RealityView
                content.add(earthEntity)
                earth = earthEntity
            } update: { content, attachments in
                for place in favoritePlaces {
                    if let placeEntity = attachments.entity(for: place.id) {
                        content.add(placeEntity)

                        let position = positionOnSphere(for: place.coordinate, radius: earthRadius)

                        print("position -----> ", position)

                        placeEntity.look(
                            at: .zero,
                            from: position,
                            relativeTo: placeEntity.parent)
                    }
                }

            } attachments: {
                ForEach(favoritePlaces) { place in
                    Attachment(id: place.id) {
                        Image(systemName: "mappin")
                            .foregroundStyle(.red)
                            .tag(place.id)

                        // Text(place.name)
                        //     .padding()
                        //     .glassBackgroundEffect()
                        //     .tag(place.id)
                    }
                }
            }

            .overlay(alignment: .bottom) {
                Text(favoritePlaces[0].name)
                    .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .padding(.horizontal, 35)
                    .glassBackgroundEffect()
            }
        }
    }

    // Function to convert CLLocationCoordinate2D to a position on the sphere

    // v2
    func positionOnSphere(for coordinate: CLLocationCoordinate2D, radius: Float) -> SIMD3<Float> {
        let latRad = Float(coordinate.latitude) * .pi / 180.0
        let lonRad = Float(coordinate.longitude) * .pi / 180.0

        let x = radius * cos(latRad) * cos(lonRad)
        let y = radius * sin(latRad)
        let z = radius * cos(latRad) * sin(lonRad)

        return SIMD3<Float>(x, y, z)
    }

    // v1
    // func positionOnSphere(for coordinate: CLLocationCoordinate2D, radius: Float) -> SIMD3<Float> {
    //     let latRad = Float(coordinate.latitude) * .pi / 180.0
    //     let lonRad = Float(coordinate.longitude) * .pi / 180.0
    //
    //     let x = radius * cos(latRad) * cos(lonRad)
    //     let y = radius * cos(latRad) * sin(lonRad)
    //
    //     let z = radius * sin(latRad)
    //
    //     return SIMD3<Float>(x, y, z)
    // }
}

#Preview {
    EarthVolume()
}
