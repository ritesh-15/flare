import SwiftUI

struct MainTabBarScreen: View {
    
    @EnvironmentObject var router: Router
    
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
                Text("Edit Profile")
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
