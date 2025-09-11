import SwiftUI
import Foundation

@MainActor
final class SignInViewModel: ObservableObject {
    
    let authService = AuthenticationService()
    @Published var toast: Toast? = nil
    var router: Router?
    
    init(router: Router? = nil) {
        self.router = router
    }
    
    func login(email: String, password: String) {
        Task {
            do {
                let _ = try await authService.login(email: email, password: password)
                toast = Toast(style: .success, message: "Login succesfull!")
                router?.navigate(to: .main)
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
                toast = Toast(style: .error, message: error.localizedDescription)
            }
        }
    }
}
