import SwiftUI

struct InfoButton: View {
    let icon: String
    let label: String
    let value: String?
    var action: (() -> Void)? = nil
    var useCustomImage: Bool = false
    var iconSize: CGFloat = 32
    var iconOpacity: Double = 1.0

    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                if useCustomImage {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize, height: iconSize)
                        .opacity(iconOpacity)
                } else {
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(.edibleGreen)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .padding(.vertical, Spacing.sm)
            .background(Color.edibleBackground)
            .cornerRadius(CornerRadius.small)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(action == nil)
    }
}

struct InfoButtonRow: View {
    let restaurant: Restaurant

    var body: some View {
        HStack(spacing: Spacing.xs) {
            // Menu - using custom MenuBadge SVG
            InfoButton(
                icon: "MenuBadge",
                label: "Menu",
                value: restaurant.menuURL != nil ? "View" : "N/A",
                action: restaurant.menuURL != nil ? {
                    if let url = URL(string: restaurant.menuURL!) {
                        UIApplication.shared.open(url)
                    }
                } : nil,
                useCustomImage: true
            )

            // Location - using custom LocationBadge SVG
            InfoButton(
                icon: "LocationBadge",
                label: "Location",
                value: restaurant.neighborhood,
                action: {
                    let address = restaurant.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    if let googleMapsApp = URL(string: "comgooglemaps://?q=\(address)"),
                       UIApplication.shared.canOpenURL(googleMapsApp) {
                        UIApplication.shared.open(googleMapsApp)
                    } else if let appleMaps = URL(string: "http://maps.apple.com/?address=\(address)") {
                        UIApplication.shared.open(appleMaps)
                    }
                },
                useCustomImage: true
            )

            // Price - use CostBadge for $$$ and $$$$, CostBadge2 for $ and $$
            InfoButton(
                icon: restaurant.priceRange >= 3 ? "CostBadge" : "CostBadge2",
                label: "Price",
                value: restaurant.priceRangeEnum.displayString,
                useCustomImage: true,
                iconSize: 44,
                iconOpacity: 1.0
            )

            // Phone - using custom PhoneBadge SVG
            InfoButton(
                icon: "PhoneBadge",
                label: "Call",
                value: nil,
                action: {
                    if let url = URL(string: "tel:\(restaurant.phoneNumber)") {
                        UIApplication.shared.open(url)
                    }
                },
                useCustomImage: true
            )

            // Health Grade - use HealthScoreA for A, HealthScoreB for B/C
            if let grade = restaurant.healthGradeEnum {
                InfoButton(
                    icon: grade == .a ? "HealthScoreA" : "HealthScoreB",
                    label: "Grade",
                    value: grade.rawValue,
                    useCustomImage: true,
                    iconOpacity: 1.0
                )
            }
        }
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButtonRow(restaurant: Restaurant.mock())
            .padding()
    }
}
