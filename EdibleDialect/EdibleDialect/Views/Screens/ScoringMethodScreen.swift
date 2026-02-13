import SwiftUI

struct ScoringMethodScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.edibleBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        Text("Our Edible Score aggregates ratings from multiple trusted sources, each normalized to a 100-point scale. Different source types receive different curve adjustments to account for rating tendencies.")
                            .font(.edibleBody)
                            .foregroundColor(.edibleTextSecondary)
                            .lineSpacing(4)

                        // Source breakdowns
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            scoreExplanation(
                                title: "5-Star Sources",
                                sources: "Google, Yelp, MenuPages, Zomato",
                                description: "Converted to 100-point scale + 10-point curve"
                            )

                            Divider()

                            scoreExplanation(
                                title: "10-Point Sources",
                                sources: "Foursquare",
                                description: "Converted to 100-point scale, no curve"
                            )

                            Divider()

                            scoreExplanation(
                                title: "Professional Reviews",
                                sources: "NY Times, Zagat",
                                description: "Converted to 100-point scale + 20-point curve"
                            )

                            Divider()

                            HStack {
                                Text("Final Edible Score")
                                    .font(.edibleSubheadline)
                                    .foregroundColor(.edibleGreen)

                                Spacer()

                                Text("Average of all sources")
                                    .font(.edibleCaption)
                                    .foregroundColor(.edibleTextSecondary)
                            }
                        }
                        .padding(Spacing.md)
                        .background(Color.edibleCardBackground)
                        .cornerRadius(CornerRadius.medium)

                        Spacer(minLength: Spacing.xxl)
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.top, Spacing.lg)
                }
            }
            .navigationTitle("Scoring Method")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.edibleGreen)
                }
            }
        }
    }

    private func scoreExplanation(title: String, sources: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            Text(title)
                .font(.edibleSubheadline)
                .foregroundColor(.edibleTextPrimary)

            Text(sources)
                .font(.edibleCaption)
                .foregroundColor(.edibleGreen)

            Text(description)
                .font(.edibleCaption)
                .foregroundColor(.edibleTextSecondary)
        }
    }
}

struct ScoringMethodScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScoringMethodScreen()
    }
}
