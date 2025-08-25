import Appwrite
import Foundation
import JSONCodable

protocol MatchServiceProtocol {
    
    func createMatch(matchBy: String, matchTo: String) async throws -> AppwriteModels.Document<[String: AnyCodable]>
    
    func getMatches(userId: String) async throws
}

final class MatchService: MatchServiceProtocol {

    static let collectionID = "689c9e5e001cdcec255b"
    
    public func createMatch(matchBy: String, matchTo: String) async throws -> AppwriteModels.Document<[String: AnyCodable]> {
        let match = try await AppwriteProvider.shared.database.createDocument(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            documentId: ID.unique(),
            data: [
                "matchBy": matchBy,
                "matchTo": matchTo
            ])
        
        return match
    }
    
    public func getMatches(userId: String) async throws {
        let matches = try await AppwriteProvider.shared.database.listDocuments(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID)
    }
}
