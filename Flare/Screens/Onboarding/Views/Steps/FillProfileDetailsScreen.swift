import SwiftUI
import PhotosUI

struct FillProfileDetailsScreen: View {

    @EnvironmentObject var router: Router

    @StateObject private var viewModel = FillProfileDetailsViewModel(
        storageService: StorageService(),
        profilePictureService: ProfileImagesService(),
        profileService: ProfileService(),
        authenticationService: AuthenticationService()
    )
    
    var body: some View {
        WrapperContainer(shouldShowTopNavBar: true) {
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Profile Details")
                        .font(.system(size: 34, weight: .bold))
                    
                    Text("Please choose your best pictures and fill up your profile details")
                }
                
                SelectImagesView(viewModel: viewModel)
                
                VStack(spacing: 12) {
                    TextField("First Name", text: $viewModel.firstName)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .tint(.brandPrimary)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        }
                    
                    TextField("Last Name", text: $viewModel.lastName)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .tint(.brandPrimary)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        }
                    
                    Button {
                        viewModel.chooseBirthdate()
                    } label: {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tint(.brandPrimary)
                            .foregroundStyle(.brandPrimary)
                            .frame(width: 24, height: 24)
                        
                        Text(viewModel.isBirthDateChoosen ? "\(viewModel.getFormattedDate())" : "Choose birth date")
                            .tint(.brandPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.brandPrimary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                }
                
                FButton(action: {
                    viewModel.fillProfileDetails()
                }, text: "Continue")
            }
            .padding(.top, 24)
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 24)
        .sheet(isPresented: $viewModel.shouldShowChooseBirthDateSheet) {
            VStack(alignment: .leading) {
                DatePicker(
                    "Choose birthdate",
                    selection: $viewModel.birthDate,
                    in: ...Date(),
                    displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .pickerStyle(.inline)
                    .tint(.brandPrimary)
                
                FButton(action: {
                    viewModel.saveBirthDate()
                }, text: "Save")
            }
            .padding(.horizontal, 40)
            .presentationDetents([.medium])
        }
        .toastView(toast: $viewModel.toast)
        .onAppear {
            viewModel.router = router
        }
    }
}

struct SelectImagesView: View {
    
    @ObservedObject var viewModel: FillProfileDetailsViewModel
    var cellSize: CGFloat = (UIScreen.main.bounds.width - (24 * 4)) / 3
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ], spacing: 12) {
            ForEach(0..<6) { index in
                PhotosPicker(
                    selection: Binding(get: {
                        return nil
                    }, set: { item in
                        if let item {
                            viewModel.loadImage(from: item, into: index)
                        }
                    }), photoLibrary: .shared()) {
                        ZStack {
                            if let uiImage = viewModel.images[index] {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: cellSize, height: cellSize)
                                    .clipped()
                                    .cornerRadius(15)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                    .foregroundStyle(.gray.opacity(0.5))
                            }
                        }
                        .frame(width: cellSize, height: cellSize)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray.opacity(0.15), lineWidth: 1)
                        }
                    }
            }
        }
    }
}

#Preview {
    FillProfileDetailsScreen()
}
