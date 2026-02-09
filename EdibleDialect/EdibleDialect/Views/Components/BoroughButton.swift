import SwiftUI

struct BoroughButton: View {
    let borough: Borough
    let isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(borough.displayName)
                .font(.edibleBody)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .edibleTextPrimary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.sm)
                .background(isSelected ? Color.edibleGreen : Color.edibleCardBackground)
                .cornerRadius(CornerRadius.pill)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.pill)
                        .stroke(isSelected ? Color.clear : Color.edibleBorder, lineWidth: 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BoroughSelector: View {
    @Binding var selectedBorough: Borough?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                // All option
                Button(action: {
                    selectedBorough = nil
                }) {
                    Text("All")
                        .font(.edibleBody)
                        .fontWeight(.medium)
                        .foregroundColor(selectedBorough == nil ? .white : .edibleTextPrimary)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(selectedBorough == nil ? Color.edibleGreen : Color.edibleCardBackground)
                        .cornerRadius(CornerRadius.pill)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.pill)
                                .stroke(selectedBorough == nil ? Color.clear : Color.edibleBorder, lineWidth: 1)
                        )
                }
                .buttonStyle(PlainButtonStyle())

                ForEach(Borough.allCases) { borough in
                    BoroughButton(
                        borough: borough,
                        isSelected: selectedBorough == borough,
                        action: {
                            selectedBorough = borough
                        }
                    )
                }
            }
            .padding(.horizontal, Spacing.md)
        }
    }
}

struct BoroughButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BoroughButton(borough: .manhattan, isSelected: true, action: {})
            BoroughButton(borough: .brooklyn, isSelected: false, action: {})
            BoroughSelector(selectedBorough: .constant(.manhattan))
        }
        .padding()
        .background(Color.edibleBackground)
    }
}
