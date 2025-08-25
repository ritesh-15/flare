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

struct ProfileCardModel: Identifiable, Equatable {
    let id: String
    let firstName: String
    let lastName: String
    let position: String
    let gender: Gender
    let birthDate: Date
    let profilePictures: [String]
    let interests: [String]
    let userId: String
}
