import Foundation
import SwiftUI

enum AppTab: Hashable, Codable {
    case discover
    case matches
    case messages
    case profile
}

enum AutheticationWith: Hashable, Codable, Sendable {
    case email
    case mobile
}

// MARK: - Tab routes

enum DiscoverRoutes: Hashable, Codable {
    case profileDetail
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .profileDetail:
            Text("Profile Detail")
        }
    }
}

enum MatchesRoutes: Hashable, Codable {
    case profileDetail
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .profileDetail:
            Text("Profile Detail")
        }
    }
}

enum MessagesRoutes: Hashable, Codable {
    case thread
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .thread:
            Text("Messaging thread")
        }
    }
}

enum ProfileRoutes: Hashable, Codable {
    case edit
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .edit:
            Text("Edit profile")
        }
    }
}

// MARK: - Main app routes

enum AppRoutes: Hashable, Codable {
    case carousel
    case signin
    case signup
    case emailOrMobileAuthentication(with: AutheticationWith)
    case otpInput
    case fillProfileDetails
    case setNewPassword
    case main
    case profileDetail(profileId: String)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .carousel:
            OnboardingCarouselScreen()
        case .signin:
            SignInScreen()
        case .signup:
            SignUpScreen()
        case .emailOrMobileAuthentication(let with):
            MobileOrEmailAuthenticationScreen(with: with)
        case .otpInput:
            OtpInputScreen()
        case .fillProfileDetails:
            FillProfileDetailsScreen()
        case .main:
            MainTabBarScreen()
        case .setNewPassword:
            SetNewPasswordScreen()
        case .profileDetail(let profileId):
            ProfileScreen(profileId: profileId)
        }
    }
}

final class Router: ObservableObject {

    @Published var navigationPath = NavigationPath()

    func navigate(to destination: AppRoutes) {
        navigationPath.append(destination)
    }
    
    func navigate<T: Hashable>(to destination: T) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
