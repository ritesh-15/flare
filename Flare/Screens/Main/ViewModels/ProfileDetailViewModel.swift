import Foundation

@MainActor
final class ProfileDetailViewModel: ObservableObject {

    @Published var profile: ProfileCardModel?
    @Published var isFetching: Bool = true
    
    private var profileService: ProfileService
    
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    
    // MARK: - Public methods
    
    func getFullName() -> String {
        guard let profile else {
            return ""
        }
        
        return profile.firstName + profile.lastName
    }
    
    func getAge() -> Int {
        guard let profile else {
            return 0
        }
        
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: profile.birthDate, to: now)
        return ageComponents.year ?? 0
    }
    
    func fetchProfile(profileId: String) {
        Task {
            do {
                let profile = try await profileService.getProfileByID(profileId: profileId)
                self.profile = profile
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
        }
    }
}
