import SwiftUI

struct AirportDetailsWindow: View {
    var viewModel: AirportsView.ViewModel

    @Binding var airportId: Airport.ID?

    var selectedAirport: Airport {
        viewModel.getAirportById(airportId: airportId)
    }

    var body: some View {
        AirportDetailsContentView(airport: selectedAirport)
            .padding(.top, 35)
    }
}

#Preview(windowStyle: .automatic) {
    let viewModel = AirportsView.ViewModel()
    let aiportId = viewModel.airports.allAirports[0].id

    AirportDetailsWindow(viewModel: viewModel, airportId: .constant(aiportId))
}
