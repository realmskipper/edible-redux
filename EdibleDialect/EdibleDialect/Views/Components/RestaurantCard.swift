import SwiftUI

struct RestaurantCard: View {
    let restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image
            ZStack(alignment: .bottomTrailing) {
                Image(restaurant.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180)
                    .clipped()

                // Score Badge
                ScoreBadge(score: restaurant.edibleScore, size: .medium)
                    .padding(Spacing.sm)
            }

            // Info
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(restaurant.name)
                    .font(.edibleSubheadline)
                    .foregroundColor(.edibleTextPrimary)
                    .lineLimit(1)

                HStack(spacing: Spacing.xs) {
                    Text(restaurant.cuisineType)
                        .font(.edibleCaption)
                        .foregroundColor(.edibleTextSecondary)

                    Text("•")
                        .foregroundColor(.edibleTextSecondary)

                    Text(restaurant.neighborhood)
                        .font(.edibleCaption)
                        .foregroundColor(.edibleTextSecondary)
                        .lineLimit(1)

                    Spacer()

                    // Badge icons
                    HStack(spacing: 6) {
                        Image(restaurant.priceRange >= 3 ? "CostBadge" : "CostBadge2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 22)

                        if let grade = restaurant.healthGradeEnum {
                            Image(grade == .a ? "HealthScoreA" : "HealthScoreB")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 22)
                        }

                        Button(action: {
                            let address = restaurant.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            if let googleMapsApp = URL(string: "comgooglemaps://?q=\(address)"),
                               UIApplication.shared.canOpenURL(googleMapsApp) {
                                UIApplication.shared.open(googleMapsApp)
                            } else if let appleMaps = URL(string: "http://maps.apple.com/?address=\(address)") {
                                UIApplication.shared.open(appleMaps)
                            }
                        }) {
                            Image("LocationBadge")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 22)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(Spacing.md)
        }
        .background(Color.edibleCardBackground)
        .cornerRadius(CornerRadius.medium)
        .edibleCardShadow()
    }
}

struct RestaurantCard_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCard(restaurant: Restaurant.mock())
            .padding()
            .background(Color.edibleBackground)
    }
}
