import SwiftUI

struct AccountScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.edibleBackground
                    .ignoresSafeArea()

                VStack(spacing: Spacing.lg) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.edibleGreen)

                    Text("Account")
                        .font(.edibleHeadline)
                        .foregroundColor(.edibleTextPrimary)

                    Text("Coming soon")
                        .font(.edibleBody)
                        .foregroundColor(.edibleTextSecondary)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct AccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountScreen()
    }
}
