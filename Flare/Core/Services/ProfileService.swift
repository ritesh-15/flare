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
    
    func getProfiles() async throws -> [ProfileCardModel] {
        let profiles = try await AppwriteProvider.shared.database.listDocuments(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID)
        
        // Transform the data
        let transformedData =  profiles.documents.compactMap { document -> ProfileCardModel? in
            let data = document.data
    
            guard let firstName = data["firstName"]?.value as? String,
                  let lastName = data["lastName"]?.value as? String,
                  let position = data["position"]?.value as? String,
                  let gender = data["gender"]?.value as? String,
                  let profilePictures = transformProfilePictures(profilePictures: data["profilePictures"]) else {
                return nil
            }

            return ProfileCardModel(
                firstName: firstName,
                lastName: lastName,
                position: position,
                gender: Gender(rawValue: gender) ?? .female,
                birthDate: Date(),
                profilePictures: profilePictures,
                interests: [],
                userId: "")
        }
        
        return transformedData
    }
    
    // MARK: - Private Helpers
    
    private func transformProfilePictures(profilePictures: AnyCodable?) -> [String]? {
        guard let pictures = profilePictures?.value as? [[String: Any]] else {
            return nil
        }
        
        return pictures.compactMap { pic in
            pic["imageUrl"] as? String
        }
    }
}
