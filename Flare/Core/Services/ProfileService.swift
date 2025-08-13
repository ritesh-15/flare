import Appwrite
import Foundation
import JSONCodable

final class ProfileService {
    
    static let collectionID = "689ae08b000287fa4259"
    
    func createProfile(firstName: String,
                       lastName: String,
                       birthDate: Date,
                       profilePicture: [String],
                       userId: String) async throws -> AppwriteModels.Document<[String: AnyCodable]> {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let birthdateString = isoFormatter.string(from: birthDate)
        
        let profile = try await AppwriteProvider.shared.database.createDocument(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            documentId: ID.unique(),
            data: [
                "firstName": firstName,
                "lastName": lastName,
                "birthDate": birthdateString,
                "profilePictures": profilePicture,
                "userId": userId,
            ])
        
        return profile
    }
    
}
