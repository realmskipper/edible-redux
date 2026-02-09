import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var tabState: AppTabState
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedBorough: Borough? = nil
    @State private var searchText = ""
    @State private var selectedRestaurant: Restaurant? = nil
    @State private var showAbout = false
    @State private var currentTagline = ""
    @State private var showInfoButton = true
    @State private var showTagline = true

    private let taglines = [
        "we're talking food",
        "Find your next favorite",
        "Your table awaits",
        "Dinner, decided",
        "Your guide to great eats",
        "Real reviews. Real flavor",
        "The verdict on every dish"
    ]

    var filteredRestaurants: [Restaurant] {
        var restaurants = viewModel.restaurants

        // Filter by borough
        if let borough = selectedBorough {
            restaurants = restaurants.filter { $0.borough == borough.rawValue }
        }

        // Filter by search
        if !searchText.isEmpty {
            let query = searchText.lowercased()
            restaurants = restaurants.filter {
                $0.name.lowercased().contains(query) ||
                $0.cuisineType.lowercased().contains(query) ||
                $0.neighborhood.lowercased().contains(query)
            }
        }

        return restaurants
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.edibleBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        // Header
                        headerView

                        // Search
                        SearchBar(text: $searchText, externalFocus: $tabState.shouldFocusSearch)
                            .padding(.horizontal, Spacing.md)

                        // Borough Filter
                        BoroughSelector(selectedBorough: $selectedBorough)

                        // Featured Section (only when no search/filter)
                        if searchText.isEmpty && selectedBorough == nil {
                            featuredSection
                        }

                        // Restaurant List
                        restaurantListSection
                    }
                    .padding(.bottom, Spacing.xl)
                }

                // Floating info button that fades out
                if showInfoButton {
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: { showAbout = true }) {
                                Image(systemName: "info.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(Spacing.sm)
                                    .background(Color.edibleGreen.opacity(0.6))
                                    .clipShape(Circle())
                            }
                            .padding(.trailing, Spacing.md)
                            .padding(.top, Spacing.md)
                        }
                        Spacer()
                    }
                    .transition(.opacity)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedRestaurant) { restaurant in
                RestaurantDetailScreen(restaurant: restaurant)
            }
            .sheet(isPresented: $showAbout) {
                AboutScreen()
            }
            .onAppear {
                if currentTagline.isEmpty {
                    currentTagline = taglines.randomElement() ?? taglines[0]
                }
                // Fade out tagline after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeOut(duration: 1.5)) {
                        showTagline = false
                    }
                }
                // Fade out info button after 10 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    withAnimation(.easeOut(duration: 2.0)) {
                        showInfoButton = false
                    }
                }
            }
        }
    }

    // MARK: - Header View
    private var headerView: some View {
        VStack(spacing: 0) {
            Text("edible dialect")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(.edibleGreen)

            if showTagline {
                Text(currentTagline)
                    .font(.edibleCaption)
                    .foregroundColor(.edibleTextSecondary)
                    .padding(.leading, Spacing.xl)
                    .offset(y: -6)
                    .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, Spacing.md)
    }

    // MARK: - Featured Section
    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Featured")
                .font(.edibleHeadline)
                .foregroundColor(.edibleTextPrimary)
                .padding(.horizontal, Spacing.md)

            VStack(spacing: Spacing.md) {
                ForEach(viewModel.featuredRestaurants) { restaurant in
                    RestaurantCard(restaurant: restaurant)
                        .padding(.horizontal, Spacing.md)
                        .onTapGesture {
                            selectedRestaurant = restaurant
                        }
                }
            }
        }
    }

    // MARK: - Restaurant List Section
    private var restaurantListSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text(sectionTitle)
                    .font(.edibleHeadline)
                    .foregroundColor(.edibleTextPrimary)

                Spacer()

                Text("\(filteredRestaurants.count) places")
                    .font(.edibleCaption)
                    .foregroundColor(.edibleTextSecondary)
            }
            .padding(.horizontal, Spacing.md)

            LazyVStack(spacing: Spacing.md) {
                ForEach(filteredRestaurants) { restaurant in
                    RestaurantCard(restaurant: restaurant)
                        .padding(.horizontal, Spacing.md)
                        .onTapGesture {
                            selectedRestaurant = restaurant
                        }
                }
            }
        }
    }

    private var sectionTitle: String {
        if let borough = selectedBorough {
            return borough.displayName
        } else if !searchText.isEmpty {
            return "Results"
        } else {
            return "All Restaurants"
        }
    }
}

// MARK: - View Model
class HomeViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var featuredRestaurants: [Restaurant] = []

    init() {
        loadData()
    }

    private func loadData() {
        restaurants = MockDataService.shared.getRestaurants()
        featuredRestaurants = MockDataService.shared.getFeaturedRestaurants()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(AppTabState())
    }
}
