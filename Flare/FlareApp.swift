import SwiftUI

@main
struct FlareApp: App {
    
    @StateObject private var navigationRouter: Router
    @StateObject private var onboardingViewModel: OnboardingViewModel
    @State private var isLoggedIn = false
    
    init() {
        let router = Router()
        self._navigationRouter = StateObject(wrappedValue: router)
        self._onboardingViewModel = StateObject(wrappedValue: OnboardingViewModel(
            authService: AuthenticationService(),
            router: router))
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationRouter.navigationPath) {
                RootView()
                    .navigationDestination(for: AppRoutes.self) { $0.destination }
            }
            .environmentObject(navigationRouter)
            .environmentObject(onboardingViewModel)
        }
    }
}
