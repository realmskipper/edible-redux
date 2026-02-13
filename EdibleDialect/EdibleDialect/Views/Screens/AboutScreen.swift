import SwiftUI

struct AboutScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.edibleBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: Spacing.xl) {
                        // Logo Section
                        logoSection

                        // About Section
                        aboutSection

                        // Scoring Section
                        scoringSection

                        // Social Links
                        socialSection

                        Spacer(minLength: Spacing.xxl)
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.top, Spacing.lg)
                }
            }
            .navigationTitle("About")
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

    private var logoSection: some View {
        VStack(spacing: Spacing.sm) {
            Image(systemName: "fork.knife.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.edibleGreen)

            Text("edible dialect")
                .font(.edibleTitle)
                .foregroundColor(.edibleGreen)

            Text("we're talking food")
                .font(.edibleCaption)
                .foregroundColor(.edibleTextSecondary)
        }
        .padding(.vertical, Spacing.lg)
    }

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("What We Do")
                .font(.edibleHeadline)
                .foregroundColor(.edibleTextPrimary)

            Text("Edible Dialect is New York City's premier restaurant review aggregator. We gather reviews from multiple trusted sources and calculate a unified Edible Score, giving you a clear, granular view of restaurant quality.")
                .font(.edibleBody)
                .foregroundColor(.edibleTextSecondary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(Color.edibleCardBackground)
        .cornerRadius(CornerRadius.medium)
    }

    private var scoringSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("How Scoring Works")
                .font(.edibleHeadline)
                .foregroundColor(.edibleTextPrimary)

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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(Color.edibleCardBackground)
        .cornerRadius(CornerRadius.medium)
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

    private var socialSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Connect With Us")
                .font(.edibleHeadline)
                .foregroundColor(.edibleTextPrimary)

            HStack(spacing: Spacing.md) {
                socialLink(icon: "link", label: "Facebook", url: "https://facebook.com")
                socialLink(icon: "at", label: "Twitter", url: "https://twitter.com")
                socialLink(icon: "camera", label: "Instagram", url: "https://instagram.com")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(Color.edibleCardBackground)
        .cornerRadius(CornerRadius.medium)
    }

    private func socialLink(icon: String, label: String, url: String) -> some View {
        Button(action: {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }) {
            VStack(spacing: Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.edibleGreen)

                Text(label)
                    .font(.edibleCaption)
                    .foregroundColor(.edibleTextSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.sm)
            .background(Color.edibleBackground)
            .cornerRadius(CornerRadius.small)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
