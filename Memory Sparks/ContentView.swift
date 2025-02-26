import SwiftUI

struct CustomTabBarView: View {
    init() {
        // Configure UITabBar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.8) // Semi-transparent black background
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isTranslucent = true
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            HistoryView(viewModel: HistoryViewModel.shared)
                .tabItem {
                    Label("History", systemImage: "book.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.8), .blue.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: .all) // Ensure it covers the entire screen
        )
    }
}

// MARK: - Preview
#Preview {
    CustomTabBarView()
}
