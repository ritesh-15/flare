import Combine
import Foundation
import PhotosUI
import SwiftUI

final class FillProfileDetailsViewModel: ObservableObject {
    
    // MARK: - Observed properties
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var birthDate = Date()
    @Published var isBirthDateChoosen = false
    @Published var shouldShowChooseBirthDateSheet = false
    
    // Images
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var images: [UIImage?] = Array(repeating: nil, count: 6)
    
    // Toast
    @Published var toast: Toast?
    
    // MARK: - Private properites
    
    private var cancelables: [AnyCancellable] = []
    private let storageService: StorageService
    private let profilePictureService: ProfileImagesService
    private let profileService: ProfileService
    private let authenticationService: AuthenticationService
    
    // MARK: - Initializer
    
    init(storageService: StorageService,
         profilePictureService: ProfileImagesService,
         profileService: ProfileService,
         authenticationService: AuthenticationService) {
        self.storageService = storageService
        self.profileService = profileService
        self.profilePictureService = profilePictureService
        self.authenticationService = authenticationService
    }
    
    // MARK: - Public methods
    
    @MainActor
    func fillProfileDetails() {
        // Validate if first name, lastname, birth date and images choosen
        guard validateFirstnameAndLastname(),
              isValidAge(),
              validateImagesChoosen() else {
            return
        }
       
        Task {
            do {
                // Upload images
                let uploadImages = images.compactMap { $0 }
                let files = try await storageService.upload(multiple: uploadImages)
                
                let profilePictureURls: [String] = files.compactMap { file in
                    return storageService.getFilePath(file: file)
                }

                // Create Profile Pictures
                let profilePictures = try await profilePictureService.createProfileImages(imageURLs: profilePictureURls)

                // Get currently logged in user
                let user = try await authenticationService.getCurrentUser()

                // Create Profile
                let profile = try await profileService.createProfile(
                    firstName: firstName,
                    lastName: lastName,
                    birthDate: birthDate,
                    profilePicture: profilePictures.compactMap { picture  in
                        picture.id},
                    userId: user.id)
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
                toast = Toast(style: .error, message: "Failed to upload the profile images, please try again 🙈")
            }
            
            // Create profile with details
        }
    }
    
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: birthDate)
    }
    
    func saveBirthDate() {
        isBirthDateChoosen = true
        shouldShowChooseBirthDateSheet = false
    }
    
    func chooseBirthdate() {
        isBirthDateChoosen = false
        shouldShowChooseBirthDateSheet = true
    }
    
    func loadImage(from item: PhotosPickerItem, into index: Int) {
        Task {
            do {
                try await item.loadTransferable(type: Data.self)
                    .publisher
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.toast = Toast(style: .error, message: "Something went wrong while parsing image, please try picking again")
                            print("[ERROR] \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] data in
                        if let uiImage = UIImage(data: data) {
                            self?.images[index] = uiImage
                        }
                    })
                    .store(in: &cancelables)
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
                toast = Toast(style: .error, message: "Something went wrong")
            }
        }
    }
    
    // MARK: - Private methods
    
    private func calculateAge(from date: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: date, to: now)
        return ageComponents.year ?? 0
    }
    
    private func isValidAge() -> Bool {
        let validAge = 18
        let currentAge = calculateAge(from: birthDate)
        
        if currentAge < validAge {
            toast = Toast(style: .error, message: "Your age should be greater than 18 years to use the application 🙈")
            return false
        }
        
        return true
    }
    
    private func validateFirstnameAndLastname() -> Bool {
        if firstName.isEmpty || lastName.isEmpty {
            toast = Toast(style: .error, message: "Firstname and lastname is required 🙈")
            return false
        }
        
        return true
    }
    
    private func validateImagesChoosen() -> Bool {
        let leastImagesCount = 3
        
        if images.count < leastImagesCount {
            toast = Toast(style: .error, message: "Please choose at least 3 profile images 💁🏼")
            return false
        }
        
        return true
    }
}
