import SwiftUI

enum AppTab: Int, CaseIterable {
    case home = 0
    case maps = 1
    case edibleExperiences = 2
    case search = 3
    case account = 4
}

class AppTabState: ObservableObject {
    @Published var selectedTab: AppTab = .home
    @Published var shouldFocusSearch: Bool = false

    func activateSearch() {
        selectedTab = .home
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.shouldFocusSearch = true
        }
    }
}
