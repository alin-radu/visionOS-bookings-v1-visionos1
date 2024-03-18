import MapKit
import SwiftUI

@main
struct Bookings_poc_visionos1App: App {
    @State var viewModel = AirportsView.ViewModel()

    var body: some Scene {
        WindowGroup("Booking App") {
            TabView {
                BookingsContentView()
                    .tabItem {
                        Text("Bookings")
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFit()
                    }

                AirportsView(viewModel: $viewModel)
                    .tabItem {
                        Text("Airports")
                        Image(systemName: "airplane")
                            .resizable()
                            .scaledToFit()
                    }
            }
        }

        WindowGroup(id: SceneType.mainWindow.rawValue) {
            AirportsView(viewModel: $viewModel)
        }

        WindowGroup("Aiport Details in New Window", for: Airport.ID.self) { $airportId in
            AirportDetailsWindow(viewModel: viewModel, airportId: $airportId)
        }
        .commandsRemoved()

        WindowGroup(id: "earth3D") {
            EarthVolume()
        }
        .windowStyle(.volumetric)
    }
}
