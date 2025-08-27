import Appwrite
import Foundation
import JSONCodable

protocol MatchServiceProtocol {
    
    func createMatch(matchBy: String, matchTo: String) async throws -> AppwriteModels.Document<[String: AnyCodable]>
    
    func getMatches(userId: String) async throws -> [MatchModel]
    
    func unmatch(matchId: String) async throws
    
    func match(matchId: String) async throws
}

final class MatchService: MatchServiceProtocol {
    
    static let collectionID = "689c9e5e001cdcec255b"
    
    func createMatch(matchBy: String, matchTo: String) async throws -> AppwriteModels.Document<[String: AnyCodable]> {
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
    
    func getMatches(userId: String) async throws -> [MatchModel] {
        let matches = try await AppwriteProvider.shared.database.listDocuments(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            queries: [
                Query.or([
                    Query.equal("matchBy", value: userId),
                    Query.equal("matchTo", value: userId),
                ])
            ])
        
        let transformedData = matches.documents.compactMap { document -> MatchModel? in
            let data = document.data
            return transformMatches(data: data)
        }
        
        return transformedData
    }

    func unmatch(matchId: String) async throws {
        let _ = try await AppwriteProvider.shared.database.updateDocument(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            documentId: matchId,
            data: [
                "status": MatchStatus.unmatch.rawValue
            ])
    }
    
    func match(matchId: String) async throws {
        let _ = try await AppwriteProvider.shared.database.updateDocument(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            documentId: matchId,
            data: [
                "status": MatchStatus.match.rawValue
            ])
    }
    
    // MARK: - Private methods
    
    private func transformMatches(data: [String: AnyCodable]) -> MatchModel? {
        guard let id = data["$id"]?.value as? String,
              let matchBy = data["matchBy"]?.value as? [String: Any],
              let matchTo = data["matchTo"]?.value as? [String: Any],
              let status = data["status"]?.value as? String else {
            return nil
        }
        
        guard let matchByTransformed = ProfileService.transformProfile(data: matchBy),
              let matchToTransformed = ProfileService.transformProfile(data: matchTo) else {
            return nil
        }
        
        return MatchModel(
            id: id,
            matchBy: matchByTransformed,
            matchTo: matchToTransformed,
            status: MatchStatus(rawValue: status) ?? .pending)
    }
}
