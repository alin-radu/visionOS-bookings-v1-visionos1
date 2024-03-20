import MapKit
import SwiftUI

struct AiportMapView: View {
    let airport: Airport

    @State var position: MapCameraPosition
    @State var satellite: Bool
    @State var selectedTag: Int?

    init(airport: Airport, position: MapCameraPosition) {
        print("---> AiportMapView | init | name: \(airport.name)")

        self.airport = airport
        _position = State(initialValue: position)
        _satellite = State(initialValue: false)
    }

    var body: some View {
        Map(position: $position, interactionModes: [.all], selection: $selectedTag) {
            Annotation(airport.name, coordinate: airport.coordinate) {
                VStack {
                    Text(airport.name)
                    Image(systemName: "airplane")
                        .padding(10)
                        .imageScale(selectedTag == airport.id ? .large : .small)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(selectedTag == airport.id ? .green : .clear)
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.secondary, lineWidth: 3)
                            }
                        )
                }
            }
            .annotationTitles(.hidden)
            .tag(airport.id)
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .mapControls({
            MapCompass()
            MapScaleView()
        })
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.medium)
                    .padding(3)
                    .shadow(radius: 3)
                    .padding(.horizontal, -20)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
        .clipShape(.rect(cornerRadius: 10))
        .onChange(of: airport) {
            print("---> AiportMapView | onChange")
            position = .camera(MapCamera.getMapCameraPosition(coordinate: airport.coordinate, cameraPosition: .standard))
        }
        .onChange(of: selectedTag) {
            print("---> AiportMapView | onChange | selectedTag ------------>")
        }
    }
}

#Preview(windowStyle: .automatic) {
    let airport = Airports().allAirports[1]

    AiportMapView(airport: airport, position: .camera(MapCamera.getMapCameraPosition(coordinate: airport.coordinate, cameraPosition: .standard)))
}
