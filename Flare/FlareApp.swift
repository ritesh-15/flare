import SwiftUI

@main
struct FlareApp: App {
    
    @ObservedObject private var navigationRouter = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationRouter.navigationPath) {
                ContentView()
                    .navigationDestination(for: Router.AppRoutes.self) { path in
                        switch path {
                        case .carousel: OnboardingCarouselScreen()
                        case .signin: SignInScreen()
                        case .signup: SignUpScreen()
                        }
                    }
            }
            .environmentObject(navigationRouter)
        }
    }
}
