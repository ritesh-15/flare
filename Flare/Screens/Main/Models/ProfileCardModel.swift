import Foundation

enum Gender: String, Codable {
    case male
    case female
    case other
    
    var title: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .other:
            return "Other"
        }
    }
}

struct Interest: Equatable, Identifiable, Hashable {
    let id: String = UUID().uuidString
    let name: String
    let systemImage: String
}

struct ProfileCardModel: Identifiable, Equatable, Hashable {
    let id: String
    let firstName: String
    let lastName: String
    let position: String
    let gender: Gender
    let birthDate: Date
    let profilePictures: [String]
    let interests: [Interest]
    let userId: String
    let location: String?
    let distance: Int?
    let about: String?
}
