import SwiftUI

// MARK: - Brand Colors
extension Color {
    static let edibleGreen = Color(hex: "00563F")
    static let edibleGreenLight = Color(hex: "007A5A")
    static let edibleGreenDark = Color(hex: "003D2D")
    static let edibleBackground = Color(hex: "FAFAFA")
    static let edibleCardBackground = Color.white
    static let edibleTextPrimary = Color(hex: "1A1A1A")
    static let edibleTextSecondary = Color(hex: "6B6B6B")
    static let edibleBorder = Color(hex: "E5E5E5")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Typography
extension Font {
    static let edibleTitle = Font.system(size: 32, weight: .bold)
    static let edibleHeadline = Font.system(size: 24, weight: .bold)
    static let edibleSubheadline = Font.system(size: 18, weight: .semibold)
    static let edibleBody = Font.system(size: 16, weight: .regular)
    static let edibleCaption = Font.system(size: 14, weight: .regular)
    static let edibleScore = Font.system(size: 48, weight: .bold)
    static let edibleScoreSmall = Font.system(size: 24, weight: .bold)
    static let edibleBrand = Font.system(size: 20, weight: .bold)
}

// MARK: - Spacing
enum Spacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

// MARK: - Corner Radius
enum CornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let pill: CGFloat = 24
}

// MARK: - Shadows
extension View {
    func edibleCardShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }

    func edibleSubtleShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

// MARK: - View Modifiers
struct EdibleCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.edibleCardBackground)
            .cornerRadius(CornerRadius.medium)
            .edibleCardShadow()
    }
}

extension View {
    func edibleCard() -> some View {
        self.modifier(EdibleCardStyle())
    }
}
