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
    
    func login(email: String, password: String) async throws -> AppwriteModels.Session {
        let session = try await AppwriteProvider.shared.account.createEmailPasswordSession(
            email: email,
            password: password)
        return session
    }
    
    func getCurrentUser() async throws -> AppwriteModels.User<[String: AnyCodable]> {
        let user = try await AppwriteProvider.shared.account.get()
        return user
    }
}
