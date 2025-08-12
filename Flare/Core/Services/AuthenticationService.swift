import Appwrite
import Foundation
import JSONCodable

final class AuthenticationService: Sendable {
    
    func createAccount(email: String, password: String) async throws -> AppwriteModels.User<[String: AnyCodable]> {
        let user = try await AppwriteProvider.shared.account.create(
            userId: ID.unique(),
            email: email,
            password: password)
        return user
    }
}
