import MapKit
import RealityKit
import RealityKitContent
import SwiftUI

// MARK: VIEW

struct AirportsView: View {
    @Environment(\.openWindow) private var openWindow

    @Binding var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            HStack {
                airportsList

                airportMap
            }
            .padding([.leading, .bottom, .trailing], 25)
            .searchable(text: $viewModel.searchTerm)
            .autocorrectionDisabled()
            .toolbar {
                ToolBarTop(
                    continentSelection: $viewModel.continentSelection,
                    filteredAirports: viewModel.filteredAirports
                )
            }
            .ornament(
                attachmentAnchor: .scene(.init(x: 1.040, y: 0.5)),
                contentAlignment: .center) {
                    EarthVolumeButtom(openWindow: openWindow)
            }
        }
        .onAppear {
            print("---> AirportsView | onAppear")
        }
    }
}

// MARK: PREVIEW

#Preview(windowStyle: .automatic) {
    let viewModel = AirportsView.ViewModel()

    AirportsView(viewModel: .constant(viewModel))
}

// MARK: EXTENSIONS

extension AirportsView {
    private var airportsList: some View {
        ScrollView {
            Divider()
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.filteredAirports) { airport in
                    AirportsListItem(airport: airport,
                                     selectedAirport: $viewModel.selectedAirport,
                                     openWindow: openWindow
                    )
                }
            }
            .animation(.default, value: viewModel.searchTerm)
            .animation(.default, value: viewModel.continentSelection)
        }
        .padding(.trailing, 25)
        .containerRelativeFrame(.horizontal) { size, _ in
            size * 0.5
        }
    }

    private var airportMap: some View {
        HStack {
            if let selectedAirport = viewModel.selectedAirport {
                AiportMapView(airport: selectedAirport,
                              position: .camera(.getMapCameraPosition(coordinate: selectedAirport.coordinate, cameraPosition: .standard)))
            } else {
                AiportMapView(airport: viewModel.firstFilteredAirport,
                              position: .camera(.getMapCameraPosition(coordinate: viewModel.firstFilteredAirport.coordinate, cameraPosition: .standard)))
            }
        }
    }
}

// MARK: COMPONENTS

// MARK: -

// MARK: ToolbarContent

struct ToolBarTop: ToolbarContent {
    @Binding var continentSelection: Continent

    var filteredAirports: [Airport]

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text("Airports List")
                .font(.largeTitle)
                .foregroundStyle(.primary)
                +
                Text("   \(filteredAirports.count) locations")
                .foregroundStyle(.tertiary)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Text(continentSelection.name)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Picker("Filter", selection: $continentSelection.animation()) {
                    ForEach(Continent.allCases) { continent in
                        Text(continent.name)
                    }
                }
            } label: {
                Image(systemName: "list.bullet.rectangle.fill")
            }
        }
    }
}

// MARK: AirportsListItem

struct AirportsListItem: View {
    let airport: Airport

    @Binding var selectedAirport: Airport?

    let openWindow: OpenWindowAction

    var body: some View {
        HStack {
            NavigationLink {
                AirportDetailsContentView(airport: airport)
            } label: {
                HStack {
                    Image(systemName: "airplane")
                        .imageScale(.large)
                        .foregroundStyle(.secondary.opacity(0.75))
                        .padding(7)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.tertiary, lineWidth: 1.5)
                        )
                        .shadow(color: .primary, radius: 10)
                        .padding(.trailing, 10)

                    VStack(alignment: .leading) {
                        Text(airport.name)
                            .font(.title2)
                            .foregroundStyle(.primary)
                            .padding(.bottom, 1)
                            .lineLimit(1)

                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .imageScale(.small)
                                .padding(.trailing, -3)
                            Text("\(airport.municipality), \(airport.continentFullName)")
                                .font(.title3)
                                .foregroundStyle(.tertiary)
                                .lineLimit(1)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            VStack {
                Button {
                    selectedAirport = airport
                } label: {
                    Image(systemName: "map")
                        .imageScale(.medium)
                        .help("Airport Details in New Section")
                }
                .padding(.bottom, -10)

                Button {
                    print("---> AirportsListItem | openWindow: \(airport.name)")
                    openWindow(value: airport.id)
                } label: {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait")
                        .imageScale(.medium)
                        .rotationEffect(.degrees(-90))
                        .help("Airport Details in New Window")
                }
            }
        }
        .padding(.leading, 5)
        .padding(.vertical, 5)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
        // .clipShape(.rect(cornerRadius: 10))
        .padding(.vertical, 10)
    }
}

// MARK: EarthVolumeButtom

struct EarthVolumeButtom: View {
    let openWindow: OpenWindowAction

    var body: some View {
        HStack(spacing: 0) {
            Button {
                openWindow(id: "earth3D")
            } label: {
                Image(systemName: "globe.americas.fill")
                    .resizable()
                    .scaledToFit()
                    .imageScale(.large)
                    .padding(.vertical, 35)
            }
        }
        .glassBackgroundEffect()
    }
}
