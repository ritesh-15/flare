import Combine
import Foundation
import SwiftUI

@MainActor
final class MatchesViewModel: ObservableObject {
    
    // MARK: - Private properties
    
    private let matchService: MatchServiceProtocol
    private var cancelables: Set<AnyCancellable> = []

    // MARK: - Observered properties
    
    @Published var matches: [MatchModel] = []
    @Published var isFetching = true
    
    @AppStorage("profileId") var profileId: String?
    
    init(matchService: MatchServiceProtocol) {
        self.matchService = matchService
        fetchMatches()
    }
    
    // MARK: - Public methods

    func unmatch(matchId: String) {
        Task {
            do {
                try await matchService.unmatch(matchId: matchId)
                fetchMatches()
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
        }
    }

    func match(matchId: String) {
        Task {
            do {
                try await matchService.match(matchId: matchId)
                fetchMatches()
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMatches() {
        guard let profileId else {
            return
        }
        
        Task {
            do {
                let matches = try await matchService.getMatches(userId: profileId)
                self.matches = matches
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
        }
    }
}
