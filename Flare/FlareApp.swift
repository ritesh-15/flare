import SwiftUI

@main
struct FlareApp: App {
    
    @StateObject private var navigationRouter = Router()
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationRouter.navigationPath) {
                ContentView()
                    .navigationDestination(for: AppRoutes.self) { $0.destination }
            }
            .environmentObject(navigationRouter)
        }
    }
}
