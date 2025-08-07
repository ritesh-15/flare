import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    enum AppRoutes: Hashable, Codable {
        // Onboarding Flow
        case carousel
        case signin
        case signup
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
