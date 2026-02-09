import SwiftUI
import MapKit

struct MapScreen: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedRestaurant: Restaurant? = nil
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7380, longitude: -73.9700),
            span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        )
    )

    var body: some View {
        NavigationStack {
            ZStack {
                Color.edibleBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    Text("Map")
                        .font(.edibleHeadline)
                        .foregroundColor(.edibleTextPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.md)

                    // Map
                    Map(position: $cameraPosition) {
                        ForEach(viewModel.restaurants.filter { $0.coordinate != nil }) { restaurant in
                            Annotation(restaurant.name, coordinate: restaurant.coordinate!) {
                                mapPin(for: restaurant)
                            }
                        }
                    }
                    .mapStyle(.standard)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedRestaurant) { restaurant in
                RestaurantDetailScreen(restaurant: restaurant)
            }
        }
    }

    private func mapPin(for restaurant: Restaurant) -> some View {
        Button(action: { selectedRestaurant = restaurant }) {
            VStack(spacing: 2) {
                ZStack {
                    Circle()
                        .fill(Color.edibleGreen)
                        .frame(width: 36, height: 36)
                    Text("\(restaurant.edibleScore)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.system(size: 8))
                    .foregroundColor(.edibleGreen)
                    .offset(y: -4)
            }
        }
    }
}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
