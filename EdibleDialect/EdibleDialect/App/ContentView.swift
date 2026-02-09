import SwiftUI

struct ContentView: View {
    @StateObject private var tabState = AppTabState()

    var body: some View {
        TabView(selection: $tabState.selectedTab) {
            HomeScreen()
                .tabItem {
                    TabIcon(systemName: "flame.fill")
                    Text("Home")
                }
                .tag(AppTab.home)

            MapScreen()
                .tabItem {
                    TabIcon(systemName: "map.fill")
                    Text("Maps")
                }
                .tag(AppTab.maps)

            EdibleExperiencesScreen()
                .tabItem {
                    TabIcon(systemName: "sparkles")
                    Text("Experiences")
                }
                .tag(AppTab.edibleExperiences)

            Color.edibleBackground
                .tabItem {
                    TabIcon(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(AppTab.search)

            AccountScreen()
                .tabItem {
                    TabIcon(systemName: "person.fill")
                    Text("Account")
                }
                .tag(AppTab.account)
        }
        .tint(.edibleGreen)
        .environmentObject(tabState)
        .onChange(of: tabState.selectedTab) { _, newValue in
            if newValue == .search {
                tabState.activateSearch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
