import SwiftUI

struct RootView: View {
    
    @State private var isUserLoggedIn = false
    @State private var isLoading = true

    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if isUserLoggedIn {
                MainTabBarScreen()
            } else {
                OnboardingCarouselScreen()
            }
        }
        .task {
            await authenticate()
        }
    }
}

extension RootView {
    
    func authenticate() async {
        let authService = AuthenticationService()
        do {
            let _ = try await authService.getCurrentUser()
            isUserLoggedIn = true
        } catch let error {
            isUserLoggedIn = false
            print("[ERROR] \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}

#Preview {
    RootView()
}
