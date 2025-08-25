import SwiftUI

struct RootView: View {
    
    @State private var isUserLoggedIn = false
    @State private var isLoading = true
    @AppStorage("userId") private var userId: String?

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
            let user = try await authService.getCurrentUser()
            userId = user.id
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
