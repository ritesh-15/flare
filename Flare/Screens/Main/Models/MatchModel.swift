import Foundation

enum MatchStatus: String, Codable {
    case match
    case unmatch
    case blocked
    case pending
}

struct MatchModel: Identifiable {
    let id: String
    let matchBy: ProfileCardModel
    let matchTo: ProfileCardModel
    let status: MatchStatus
}
