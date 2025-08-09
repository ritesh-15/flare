import SwiftUI

struct MainTabBarScreen: View {
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
                
            }
        }
        .background(.gray)
        .tint(.brandPrimary)
    }
}

#Preview {
    MainTabBarScreen()
}
