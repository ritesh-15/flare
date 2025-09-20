import Foundation
import SwiftUI

@MainActor
final class MessagesViewModel: ObservableObject {

    private var profileService: ProfileService

    @Published var profiles: [ProfileCardModel] = []
    @Published var isFetching: Bool = true

    @AppStorage("userId") private var userId: String?

    init(profileService: ProfileService) {
        self.profileService = profileService
        getProfiles()
    }

    func getProfiles() {
        guard let userId else {
            return
        }

        Task {
            do {
                let profiles = try await profileService.getProfiles(userId: userId)
                self.profiles = profiles
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }

            isFetching = false
        }
    }
}
