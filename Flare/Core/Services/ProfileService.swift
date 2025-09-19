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
            return Self.transformProfile(data: data)
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
              let transformedData = Self.transformProfile(data: profile.data) else {
            throw CustomError.notFound("Profile not found with userId: \(userId) or failed to transform the data")
        }
        
        return transformedData
    }
    
    func getProfileByID(profileId: String) async throws -> ProfileCardModel {
        let profile = try await AppwriteProvider.shared.database.getDocument(
            databaseId: AppwriteProvider.databaseID,
            collectionId: Self.collectionID,
            documentId: profileId)
        
        guard let transformedData = Self.transformProfile(data: profile.data) else {
            throw CustomError.notFound("Profile not found with profileId: \(profileId) or failed to transform the data")
        }
        
        return transformedData
    }
        
    static func transformProfile(data: [String: AnyCodable]) -> ProfileCardModel? {
        guard let firstName = data["firstName"]?.value as? String,
              let id = data["$id"]?.value as? String,
              let lastName = data["lastName"]?.value as? String,
              let birthDate = data["birthDate"]?.value as? String,
              let profilePictures = Self.transformProfilePictures(profilePictures: data["profilePictures"]) else {
            return nil
        }

        let about = data["about"]?.value as? String ?? ""
        let location = data["location"]?.value as? String ?? ""
        let distance = data["distance"]?.value as? Int ?? 0
        let position = data["position"]?.value as? String ?? ""
        let gender = data["gender"]?.value as? String ?? "other"

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return ProfileCardModel(
            id: id,
            firstName: firstName,
            lastName: lastName,
            position: position ?? "",
            gender: Gender(rawValue: gender) ?? .other,
            birthDate: formatter.date(from: birthDate) ?? Date(),
            profilePictures: profilePictures,
            interests: [],
            userId: "",
            location: location,
            distance: distance,
            about: about)
    }
    
    static func transformProfile(data: [String: Any]) -> ProfileCardModel? {
        guard let firstName = data["firstName"] as? String,
              let id = data["$id"] as? String,
              let lastName = data["lastName"] as? String,
              let birthDate = data["birthDate"] as? String,
              let profilePictures = Self.transformProfilePictures(profilePictures: AnyCodable(data["profilePictures"] as Any)) else {
            return nil
        }

        let about = data["about"] as? String
        let location = data["location"] as? String
        let distance = data["distance"] as? Int
        let position = data["position"] as? String ?? ""
        let gender = data["gender"] as? String ?? "other"

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return ProfileCardModel(
            id: id,
            firstName: firstName,
            lastName: lastName,
            position: position,
            gender: Gender(rawValue: gender) ?? .female,
            birthDate: formatter.date(from: birthDate) ?? Date(),
            profilePictures: profilePictures,
            interests: [],
            userId: "",
            location: location,
            distance: distance,
            about: about)
    }
    
    static func transformProfilePictures(profilePictures: AnyCodable?) -> [String]? {
        guard let pictures = profilePictures?.value as? [[String: Any]] else {
            return []
        }
        
        return pictures.compactMap { pic in
            pic["imageUrl"] as? String
        }
    }
    
    static func transformInterests(interests: AnyCodable?) -> [Interest]? {
        guard let interests = interests?.value as? [[String: Any]] else {
            return []
        }
        
        return interests.compactMap { interest in
            if let systemImage = interest["systemImageName"] as? String,
               let name = interest["name"] as? String {
                return Interest(name: name, systemImage: systemImage)
            } else {
                return nil
            }
        }
    }
}
