import SwiftUI

struct MainTabBarScreen: View {
    var body: some View {
        TabView {
            Tab("Discover", systemImage: "waveform") {
                DiscoverScreen()
            }
            
            Tab("Likes", systemImage: "heart") {
                
            }
            
            Tab("Messages", systemImage: "message") {
                
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
