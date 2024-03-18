import MapKit
import SwiftUI

struct AirportDetailsContentView: View {
    let airport: Airport

    init(airport: Airport) {
        self.airport = airport
    }

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing) {
                Text("Airport Details")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)

                DetailItem(label: "Airport Name", value: airport.name)
                Divider()
                    .overlay(.tertiary)

                DetailItem(label: "Continent", value: airport.continentFullName)
                Divider()
                    .overlay(.tertiary)

                DetailItem(label: "Municipality", value: airport.municipality)
                Divider()
                    .overlay(.tertiary)

                DetailItem(label: "Airport Size", value: airport.airportType)
                Divider()
                    .overlay(.tertiary)

                if airport.home_link != nil && airport.home_link != "" {
                    DetailItem(label: "website", value: airport.home_link ?? "No website found")
                    Divider()
                        .overlay(.tertiary)
                }
                Spacer()
            }
            .padding(15)
            .background(.gray.opacity(0.25) , in: .rect)
            .clipShape(.rect(cornerRadius: 10))
            .containerRelativeFrame(.horizontal) { size, _ in
                size * 0.35
            }
            .padding(.trailing, 15)

            AiportMapView(airport: airport,
                          position: MapCameraPosition.camera(
                              MapCamera.getMapCameraPosition(coordinate: airport.coordinate, cameraPosition: .standard)))
        }
        .padding([.leading, .bottom, .trailing], 25)
    }
}

#Preview(windowStyle: .automatic) {
    let airports: [Airport] = Bundle.main.decode("airports-SML.json")

    AirportDetailsContentView(airport: airports[0])
}

struct DetailItem: View {
    let label: String
    let value: String

    var body: some View {
        VStack {
            Text(label)
                .font(.body)
                .foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            Text(value)
                .font(.title)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
