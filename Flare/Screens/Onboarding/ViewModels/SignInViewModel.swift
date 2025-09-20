import SwiftUI
import Foundation

@MainActor
final class SignInViewModel: ObservableObject {
    
    let authService = AuthenticationService()
    let profileService = ProfileService()

    @Published var toast: Toast? = nil

    @AppStorage("userId") private var userId: String?
    @AppStorage("profileId") private var profileId: String?

    var router: Router?
    
    init(router: Router? = nil) {
        self.router = router
    }
    
    func login(email: String, password: String) {
        Task {
            do {
                let user = try await authService.login(email: email, password: password)
                let profile = try await profileService.getProfileByUserId(userId: user.id)
                toast = Toast(style: .success, message: "Login succesfull!")
                userId = user.id
                profileId = profile.id
                router?.navigate(to: .main)
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
                toast = Toast(style: .error, message: error.localizedDescription)
            }
        }
    }
}
