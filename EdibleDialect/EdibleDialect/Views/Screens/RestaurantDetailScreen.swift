import SwiftUI

struct RestaurantDetailScreen: View {
    let restaurant: Restaurant
    @Environment(\.dismiss) private var dismiss
    @State private var showAllHours = false
    @State private var aiBlurb: String?
    @State private var isLoadingBlurb = false
    @State private var blurbError: String?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.edibleBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        // Hero Image
                        heroImageView

                        // Content
                        VStack(spacing: Spacing.lg) {
                            // Restaurant Info Header
                            restaurantInfoHeader

                            // Quick Info Buttons
                            InfoButtonRow(restaurant: restaurant)
                                .padding(.horizontal, Spacing.md)

                            Divider()
                                .padding(.horizontal, Spacing.md)

                            // AI Review Blurb
                            aiBlurbSection

                            Divider()
                                .padding(.horizontal, Spacing.md)

                            // Score Section
                            scoreSection

                            Divider()
                                .padding(.horizontal, Spacing.md)

                            // Hours Section
                            hoursSection

                            Divider()
                                .padding(.horizontal, Spacing.md)

                            // Location Section
                            locationSection

                            Spacer(minLength: Spacing.xxl)
                        }
                        .padding(.top, Spacing.lg)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: shareRestaurant) {
                        Image(systemName: "square.and.arrow.up.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                }
            }
        }
    }

    // MARK: - AI Blurb Section
    private var aiBlurbSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            if isLoadingBlurb {
                HStack(spacing: Spacing.sm) {
                    ProgressView()
                        .scaleEffect(0.7)
                    Text("Our sous chef is thinking...")
                        .font(.edibleCaption)
                        .foregroundColor(.edibleTextSecondary)
                        .italic()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else if let error = blurbError {
                Text(error)
                    .font(.edibleBody)
                    .foregroundColor(.red)
            } else if let blurb = aiBlurb {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(blurb)
                        .font(.edibleBody)
                        .foregroundColor(.edibleTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("— Virtual Sous Chef")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.edibleGreen)
                }
            }
        }
        .padding(.horizontal, Spacing.md)
        .onAppear {
            generateBlurb()
        }
    }

    private func generateBlurb() {
        guard aiBlurb == nil && !isLoadingBlurb else { return }

        isLoadingBlurb = true
        blurbError = nil

        Task {
            do {
                let blurb = try await AIService.shared.generateRestaurantBlurb(for: restaurant)
                await MainActor.run {
                    aiBlurb = blurb
                    isLoadingBlurb = false
                }
            } catch {
                await MainActor.run {
                    blurbError = "Unable to generate review"
                    isLoadingBlurb = false
                }
            }
        }
    }

    // MARK: - Hero Image
    private var heroImageView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Restaurant image (square aspect ratio)
                Image(restaurant.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .clipped()

                // Gradient overlay for text readability
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color.black.opacity(0.5)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 150)

                // Score badge overlay
                HStack {
                    Spacer()
                    ScoreBadge(score: restaurant.edibleScore, size: .large)
                }
                .padding(Spacing.md)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }

    // MARK: - Restaurant Info Header
    private var restaurantInfoHeader: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(restaurant.name)
                .font(.edibleTitle)
                .foregroundColor(.edibleTextPrimary)

            HStack(spacing: Spacing.sm) {
                Label(restaurant.cuisineType, systemImage: "fork.knife")
                    .font(.edibleBody)
                    .foregroundColor(.edibleTextSecondary)

                Text("•")
                    .foregroundColor(.edibleTextSecondary)

                Text(restaurant.priceRangeEnum.displayString)
                    .font(.edibleBody)
                    .foregroundColor(.edibleTextSecondary)

                Text("•")
                    .foregroundColor(.edibleTextSecondary)

                Text(restaurant.neighborhood)
                    .font(.edibleBody)
                    .foregroundColor(.edibleTextSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Score Section
    private var scoreSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Edible Score")
                        .font(.edibleHeadline)
                        .foregroundColor(.edibleTextPrimary)

                    Text("Aggregated from \(restaurant.sourceReviews.count) sources")
                        .font(.edibleCaption)
                        .foregroundColor(.edibleTextSecondary)
                }

                Spacer()

                ScoreBadge(score: restaurant.edibleScore, size: .large)
            }
            .padding(.horizontal, Spacing.md)

            // Source breakdown
            SourceScoreList(reviews: restaurant.sourceReviews)
                .padding(.horizontal, Spacing.md)
        }
    }

    // MARK: - Hours Section
    private var hoursSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text("Hours")
                    .font(.edibleHeadline)
                    .foregroundColor(.edibleTextPrimary)

                Spacer()

                Button(action: { showAllHours.toggle() }) {
                    Text(showAllHours ? "Show Less" : "Show All")
                        .font(.edibleCaption)
                        .foregroundColor(.edibleGreen)
                }
            }
            .padding(.horizontal, Spacing.md)

            VStack(spacing: Spacing.xs) {
                if showAllHours {
                    ForEach(orderedDays, id: \.self) { day in
                        hourRow(day: day, hours: restaurant.hours[day] ?? "Closed")
                    }
                } else {
                    // Show today only
                    let formatter = DateFormatter()
                    let _ = formatter.dateFormat = "EEEE"
                    let today = formatter.string(from: Date())
                    hourRow(day: "Today", hours: restaurant.hours[today] ?? "Hours unavailable", isToday: true)
                }
            }
            .padding(.horizontal, Spacing.md)
        }
    }

    private var orderedDays: [String] {
        ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    }

    private func hourRow(day: String, hours: String, isToday: Bool = false) -> some View {
        HStack {
            Text(day)
                .font(.edibleBody)
                .fontWeight(isToday ? .semibold : .regular)
                .foregroundColor(isToday ? .edibleGreen : .edibleTextPrimary)

            Spacer()

            Text(hours)
                .font(.edibleBody)
                .foregroundColor(.edibleTextSecondary)
        }
        .padding(.vertical, Spacing.xs)
    }

    // MARK: - Location Section
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Location")
                .font(.edibleHeadline)
                .foregroundColor(.edibleTextPrimary)
                .padding(.horizontal, Spacing.md)

            Button(action: openInMaps) {
                HStack {
                    Image(systemName: "map")
                        .foregroundColor(.edibleGreen)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(restaurant.address)
                            .font(.edibleBody)
                            .foregroundColor(.edibleTextPrimary)

                        Text("\(restaurant.neighborhood), \(restaurant.borough)")
                            .font(.edibleCaption)
                            .foregroundColor(.edibleTextSecondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.edibleTextSecondary)
                }
                .padding(Spacing.md)
                .background(Color.edibleCardBackground)
                .cornerRadius(CornerRadius.medium)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, Spacing.md)
        }
    }

    // MARK: - Actions
    private func shareRestaurant() {
        let text = "Check out \(restaurant.name) on Edible Dialect! Score: \(restaurant.edibleScore)/100"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }

    private func openInMaps() {
        let address = restaurant.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        // Try Google Maps app first, fall back to Apple Maps
        if let googleMapsApp = URL(string: "comgooglemaps://?q=\(address)"),
           UIApplication.shared.canOpenURL(googleMapsApp) {
            UIApplication.shared.open(googleMapsApp)
        } else if let appleMaps = URL(string: "http://maps.apple.com/?address=\(address)") {
            UIApplication.shared.open(appleMaps)
        }
    }
}

struct RestaurantDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailScreen(restaurant: Restaurant.mock())
    }
}
