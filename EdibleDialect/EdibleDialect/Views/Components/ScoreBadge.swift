import SwiftUI

struct ScoreBadge: View {
    let score: Int
    var size: BadgeSize = .large

    enum BadgeSize {
        case small, medium, large

        var fontSize: Font {
            switch self {
            case .small: return .edibleScoreSmall
            case .medium: return Font.system(size: 36, weight: .bold)
            case .large: return .edibleScore
            }
        }

        var padding: CGFloat {
            switch self {
            case .small: return Spacing.xs
            case .medium: return Spacing.sm
            case .large: return Spacing.md
            }
        }

        var minWidth: CGFloat {
            switch self {
            case .small: return 50
            case .medium: return 70
            case .large: return 90
            }
        }
    }

    var scoreColor: Color {
        switch score {
        case 90...100: return Color.edibleGreen
        case 80..<90: return Color.edibleGreenLight
        case 70..<80: return Color(hex: "F5A623")
        case 60..<70: return Color(hex: "F5A623").opacity(0.8)
        default: return Color(hex: "D0021B")
        }
    }

    var body: some View {
        Text("\(score)")
            .font(size.fontSize)
            .foregroundColor(.white)
            .padding(.horizontal, size.padding)
            .padding(.vertical, size.padding / 2)
            .frame(minWidth: size.minWidth)
            .background(scoreColor)
            .cornerRadius(CornerRadius.small)
    }
}

struct ScoreBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ScoreBadge(score: 97, size: .large)
            ScoreBadge(score: 85, size: .medium)
            ScoreBadge(score: 72, size: .small)
        }
        .padding()
    }
}
