import Foundation

struct CountryModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let flag: String
}
