import SwiftUI

struct MainTabBarScreen: View {
    
    @EnvironmentObject var router: Router
    @AppStorage("profileId") private var profileId: String?

    var body: some View {
        TabView {
            Tab("Discover", systemImage: "waveform") {
                DiscoverScreen()
            }
            
            Tab("Likes", systemImage: "heart") {
                MatchesScreen()
            }
            
            Tab("Messages", systemImage: "message") {
                MessagesScreen()
            }
            
            Tab("Profile", systemImage: "person") {
                ProfileScreen(profileId: profileId ?? "", isSelfProfile: true)
            }
        }
        .background(.gray)
        .tint(.brandPrimary)
        .navigationDestination(for: DiscoverRoutes.self) { $0.destination }
        .navigationDestination(for: MatchesRoutes.self) { $0.destination }
        .navigationDestination(for: MessagesRoutes.self) { $0.destination }
        .navigationDestination(for: ProfileRoutes.self) { $0.destination }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainTabBarScreen()
}
