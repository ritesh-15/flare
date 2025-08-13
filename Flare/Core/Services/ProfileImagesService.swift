import Appwrite
import Foundation
import JSONCodable

final class ProfileImagesService {
    
    static let collectionID = "689ae1b2001d6cce1662"
    
    func createProfileImages(imageURLs: [String]) async throws -> [AppwriteModels.Document<[String: AnyCodable]>] {
        try await withThrowingTaskGroup(of: AppwriteModels.Document<[String: AnyCodable]>.self) { group in
            for url in imageURLs {
                group.addTask {
                    try await AppwriteProvider.shared.database.createDocument(
                        databaseId: AppwriteProvider.databaseID,
                        collectionId: Self.collectionID,
                        documentId: ID.unique(),
                        data: [
                            "imageUrl": url
                        ]
                    )
                }
            }
            
            var results: [AppwriteModels.Document<[String: AnyCodable]>] = []
            
            for try await document in group {
                results.append(document)
            }
            
            return results
        }
    }
}
