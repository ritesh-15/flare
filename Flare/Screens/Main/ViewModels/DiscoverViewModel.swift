import SwiftUI
import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let matchService: MatchServiceProtocol
    
    @AppStorage("userId") private var userId: String?
    
    // MARK: - Observered properties
    
    @Published var cards: [ProfileCardModel] = []
    @Published var isFetching = true
    
    // MARK: - Initializer
    
    init(profileService: ProfileService, matchService: MatchServiceProtocol) {
        self.profileService = profileService
        self.matchService = matchService
        getProfiles()
    }
    
    // MARK: - Public methods
    
    func swipeRight(card: ProfileCardModel, index: Int) {
        guard let userId else {
            return
        }
        
        // Create a match
        cards.removeAll { $0 == card }
        
        Task {
            do {
                // Get the profile info from user id
                let profile = try await profileService.getProfileByUserId(userId: userId)
                
                let _ = try await matchService.createMatch(matchBy: profile.id, matchTo: card.id)
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
        }
    }
    
    func swipeLeft(card: ProfileCardModel, index: Int) {
        // Remove from the list
        cards.removeAll { $0 == card }
    }
    
    func getProfiles() {
        guard let userId else {
            return
        }
        
        Task {
            do {
                let profiles = try await profileService.getProfiles(userId: userId)
                cards = profiles
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
            
            isFetching = false
        }
    }
}
