import Appwrite
import Foundation
import JSONCodable

enum CustomError: Error {
    case notFound(String)
}

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
    
    func getProfiles(userId: String) async throws -> [ProfileCardModel] {
        let profiles = try await AppwriteProvider.shared.database.listDocuments(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            queries: [
                Query.notEqual("userId", value: userId)
            ])
        
        // Transform the data
        let transformedData =  profiles.documents.compactMap { document -> ProfileCardModel? in
            let data = document.data
            return transformProfile(data: data)
        }
        
        return transformedData
    }
    
    func getProfileByUserId(userId: String) async throws -> ProfileCardModel {
        let profiles = try await AppwriteProvider.shared.database.listDocuments(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            queries: [
                Query.equal("userId", value: userId)
            ])
        
        guard let profile = profiles.documents.first,
              let transformedData = transformProfile(data: profile.data) else {
            throw CustomError.notFound("Profile not found with userId: \(userId) or failed to transform the data")
        }
        
        return transformedData
    }
    
    // MARK: - Private Helpers
    
    private func transformProfile(data: [String: AnyCodable]) -> ProfileCardModel? {
        guard let firstName = data["firstName"]?.value as? String,
              let id = data["$id"]?.value as? String,
              let lastName = data["lastName"]?.value as? String,
              let position = data["position"]?.value as? String,
              let gender = data["gender"]?.value as? String,
              let profilePictures = transformProfilePictures(profilePictures: data["profilePictures"]) else {
            return nil
        }

        return ProfileCardModel(
            id: id,
            firstName: firstName,
            lastName: lastName,
            position: position,
            gender: Gender(rawValue: gender) ?? .female,
            birthDate: Date(),
            profilePictures: profilePictures,
            interests: [],
            userId: "")
    }
    
    private func transformProfilePictures(profilePictures: AnyCodable?) -> [String]? {
        guard let pictures = profilePictures?.value as? [[String: Any]] else {
            return nil
        }
        
        return pictures.compactMap { pic in
            pic["imageUrl"] as? String
        }
    }
}
