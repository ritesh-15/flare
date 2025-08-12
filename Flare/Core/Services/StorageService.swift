import Appwrite
import Foundation
import SwiftUI

@MainActor
final class StorageService {
    
    func upload(multiple images: [UIImage]) async throws -> [File] {
        return try await withThrowingTaskGroup(of: File.self) { group in
            for image in images {
                group.addTask {
                    let imageData = image.jpegData(compressionQuality: 0.8)!
                    let inputFile = InputFile.fromData(imageData, filename: UUID().uuidString + ".jpg", mimeType: "image/jpeg")
                    return try await AppwriteProvider.shared.storage.createFile(
                        bucketId: "689ae14700002c5d39cd",
                        fileId: ID.unique(),
                        file: inputFile)
                }
            }

            var uploadedFiles: [File] = []
            for try await file in group {
                uploadedFiles.append(file)
            }

            return uploadedFiles
        }
    }
}
