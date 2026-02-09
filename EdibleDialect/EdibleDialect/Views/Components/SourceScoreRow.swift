import SwiftUI

struct SourceScoreRow: View {
    let review: SourceReview

    var body: some View {
        HStack {
            // Source icon and name
            HStack(spacing: Spacing.sm) {
                if let source = review.reviewSource {
                    Image(systemName: source.icon)
                        .foregroundColor(.edibleGreen)
                        .frame(width: 24)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(review.source)
                        .font(.edibleBody)
                        .fontWeight(.medium)
                        .foregroundColor(.edibleTextPrimary)

                    if let count = review.reviewCount {
                        Text("\(count) reviews")
                            .font(.edibleCaption)
                            .foregroundColor(.edibleTextSecondary)
                    } else if review.reviewSource?.isProfessional == true {
                        Text("Professional review")
                            .font(.edibleCaption)
                            .foregroundColor(.edibleTextSecondary)
                    }
                }
            }

            Spacer()

            // Scores
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(Int(review.convertedScore))")
                    .font(.edibleSubheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.edibleGreen)

                if let source = review.reviewSource {
                    Text("\(String(format: "%.1f", review.rawRating))/\(Int(source.maxRating))")
                        .font(.edibleCaption)
                        .foregroundColor(.edibleTextSecondary)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.edibleCardBackground)
        .cornerRadius(CornerRadius.small)
    }
}

struct SourceScoreList: View {
    let reviews: [SourceReview]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Score Breakdown")
                .font(.edibleSubheadline)
                .foregroundColor(.edibleTextPrimary)
                .padding(.horizontal, Spacing.md)

            VStack(spacing: Spacing.xs) {
                ForEach(reviews) { review in
                    SourceScoreRow(review: review)
                }
            }
        }
    }
}

struct SourceScoreRow_Previews: PreviewProvider {
    static var previews: some View {
        SourceScoreList(reviews: Restaurant.mock().sourceReviews)
            .padding()
            .background(Color.edibleBackground)
    }
}
