import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    enum AutheticationWith: Hashable, Codable {
        case email
        case mobile
    }
    
    enum AppRoutes: Hashable, Codable {
        // Onboarding Flow
        case carousel
        case signin
        case signup
        case emailOrMobileAuthentication(with: AutheticationWith)
    }
    
    @Published var navigationPath = NavigationPath()

    func navigate(to destination: AppRoutes) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
