import SwiftUI

struct RootView: View {
    
    @State private var isUserLoggedIn = false
    @State private var isLoading = true
    @AppStorage("userId") private var userId: String?
    @AppStorage("profileId") private var profileId: String?

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
        let profileService = ProfileService()
        
        do {
            let user = try await authService.getCurrentUser()
            print("[DEBUG] \(user.id)")
            let profile = try await profileService.getProfileByUserId(userId: user.id)
            userId = user.id
            profileId = profile.id
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
