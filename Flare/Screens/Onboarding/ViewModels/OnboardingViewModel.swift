import Appwrite
import SwiftUI

final class OnboardingViewModel: ObservableObject, Sendable {
    
    // MARK: - Static fields
    
    static let countries: [CountryModel] = [
        CountryModel(name: "+91", flag: "🇮🇳"),
        CountryModel(name: "+1", flag: "🇺🇸"),
        CountryModel(name: "+21", flag: "🇬🇧"),
        CountryModel(name: "+34", flag: "🇩🇪"),
        CountryModel(name: "+89", flag: "🇯🇵")
    ]
    
    // MARK: - State
    
    public let authService: AuthenticationService
    public var authenticationWith: AutheticationWith = .mobile
    
    private let router: Router
    
    // MARK: - Observable states
    
    @Published var inputText: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var toast: Toast? = nil
    @Published var selectedCountry: CountryModel?
    @Published var currentOnboardingStep: AppRoutes = .setNewPassword
    
    // MARK: - Initializer
    
    init(authService: AuthenticationService, router: Router) {
        self.authService = authService
        self.router = router
    }
    
    // MARK: - Public methods
    
    func canGoToOtpInputScreen(authenticationWith: AutheticationWith) -> Bool {
        self.authenticationWith = authenticationWith
        
        guard validateEmailOrPhoneNumber() else {
            toast = Toast(style: .error, message: "Please enter valid details")
            return false
        }
        
        return true
    }
    
    @MainActor
    func canGoToProfileDetailScreen() {
        guard validatePasswordAndConfirmPassword() else {
            return
        }
        
        Task {
            do {
                let _ = try await authService.createAccount(email: inputText, password: password)

                // Create session
                let _ = try await authService.login(email: inputText, password: password)

                router.navigate(to: .fillProfileDetails)
            } catch let error {
                toast = Toast(style: .error, message: "Something weng wrong, please try again")
                print("[ERROR] \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Heper methods
    
    private func validatePasswordAndConfirmPassword() -> Bool {
        if password.count < 8 {
            toast = Toast(style: .error, message: "Password legnth should be at least 8 characters")
            return false
        }
        
        if confirmPassword != password {
            toast = Toast(style: .error, message: "Password and confirm password should match")
            return false
        }
        
        return true
    }
    
    private func validateEmailOrPhoneNumber() -> Bool {
        if authenticationWith == .mobile {
            return isValidPhone(inputText)
        }
        
        return isValidEmail(inputText)
    }
    
    private func isValidEmail(_ text: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text)
    }
    
    private func isValidPhone(_ text: String) -> Bool {
        let phoneRegex = #"^[0-9]{10,15}$"#
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: text)
    }
}
