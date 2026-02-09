import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var externalFocus: Bool
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.edibleTextSecondary)

            TextField("Search restaurants...", text: $text)
                .font(.edibleBody)
                .foregroundColor(.edibleTextPrimary)
                .focused($isFocused)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.edibleTextSecondary)
                }
            }
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
        .background(Color.edibleCardBackground)
        .cornerRadius(CornerRadius.pill)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.pill)
                .stroke(isFocused ? Color.edibleGreen : Color.edibleBorder, lineWidth: 1)
        )
        .edibleSubtleShadow()
        .onChange(of: externalFocus) { _, newValue in
            if newValue {
                isFocused = true
                externalFocus = false
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchBar(text: .constant(""), externalFocus: .constant(false))
            SearchBar(text: .constant("Italian"), externalFocus: .constant(false))
        }
        .padding()
        .background(Color.edibleBackground)
    }
}
