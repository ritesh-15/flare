import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    
    // MARK: - Observered properties
    
    @Published var cards: [ProfileCardModel] = []
    @Published var isFetching = true
    
    // MARK: - Initializer
    
    init(profileService: ProfileService) {
        self.profileService = profileService
        getProfiles()
    }
    
    // MARK: - Public methods
    
    func swipeRight(card: ProfileCardModel, index: Int) {
        // Create a match
        cards.removeAll { $0 == card }
    }
    
    func swipeLeft(card: ProfileCardModel, index: Int) {
        // Remove from the list
        cards.removeAll { $0 == card }
    }
    
    func getProfiles() {
        Task {
            do {
                let profiles = try await profileService.getProfiles()
                cards = profiles
                print("[DEBUG] \(cards)")
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
            
            isFetching = false
        }
    }
}
