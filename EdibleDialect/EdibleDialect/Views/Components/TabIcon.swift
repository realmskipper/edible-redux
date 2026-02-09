import SwiftUI

struct TabIcon: View {
    let systemName: String
    let customImageName: String?

    init(systemName: String, customImageName: String? = nil) {
        self.systemName = systemName
        self.customImageName = customImageName
    }

    var body: some View {
        if let customImageName = customImageName {
            Image(customImageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: systemName)
        }
    }
}
