import SwiftUI

struct ProfileScreen: View {
    
    let profileId: String
    let isSelfProfile: Bool
    @EnvironmentObject var router: Router
    @ObservedObject private var viewModel = ProfileDetailViewModel(profileService: ProfileService())
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: viewModel.profile?.profilePictures.first ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 410)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: UIScreen.main.bounds.width, height: 410)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    if !isSelfProfile {
                        FIconButton(systemImagename: "chevron.left") {
                            router.navigateBack()
                        }
                        .tint(.white)
                        .padding(.top, 64)
                        .padding(.leading, 24)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .overlay(alignment: .bottom) {
                    if !isSelfProfile {
                        HStack(alignment: .center, spacing: 20) {
                            ActionIconButton(
                                imageName: "xmark",
                                backgroundColor: .white,
                                imageIconColor: .orange) {

                                }

                            ActionIconButton(
                                imageName: "heart.fill",
                                backgroundColor: .brandPrimary,
                                imageIconColor: .white,
                                circleFrame: .init(width: 90, height: 90),
                                imageFrame: .init(width: 32, height: 32)) {

                                }

                            ActionIconButton(
                                imageName: "star.fill",
                                backgroundColor: .white,
                                imageIconColor: .purple) {

                                }
                        }
                        .offset(y: 44)
                    } else {
                        HStack(alignment: .center, spacing: 20) {
                            FButton(action: {

                            }, text: "Edit profile")
                            .frame(width: 250, height: 25)
                        }
                        .padding(.horizontal, 32)
                        .offset(y: 18)
                    }
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    // Name and profession detail
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(viewModel.getFullName()), \(viewModel.getAge())")
                                .font(.system(size: 24, weight: .bold))
                            
                            Text("\(viewModel.profile?.position ?? "")")
                                .font(.system(size: 14, weight: .regular))
                        }
                        
                        Spacer()
                        
                        FIconButton(systemImagename: "message") {
                            
                        }
                        .tint(.brandPrimary)
                    }
                    
                    // Location and distance
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Location")
                                .font(.system(size: 16, weight: .bold))
                            
                            Text("\(viewModel.profile?.location ?? "")")
                                .font(.system(size: 14, weight: .regular))
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "location")
                            
                            Text("\(viewModel.profile?.distance ?? 0) Km")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .padding(8)
                        .foregroundStyle(.brandPrimary)
                        .background(.brandPrimary.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    // About
                    VStack(alignment: .leading, spacing: 5) {
                        Text("About")
                            .font(.system(size: 16, weight: .bold))
                        
                        Text("\(viewModel.profile?.about ?? "")")
                            .font(.system(size: 14, weight: .regular))
                    }
                    
                    // Interestes
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("Interests")
//                            .font(.system(size: 16, weight: .bold))
//                            .padding(.bottom, 10)
//                        
//                        LazyVGrid(columns: [
//                            GridItem(.adaptive(minimum: 100, maximum: 150))
//                        ], spacing: 8) {
//                            if let profile = viewModel.profile {
//                                ForEach(profile.interests, id: \.id) { interest in
//                                    HStack(alignment: .center, spacing: 4) {
//                                        Image(systemName: interest.systemImage)
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: 14, height: 14)
//                                            .clipped()
//                                        
//                                        Text("\(interest.name)")
//                                            .font(.system(size: 14))
//                                            .frame(maxWidth: .infinity)
//                                            .padding(.horizontal, 12)
//                                    }
//                                    padding(.vertical, 6)
//                                    .overlay {
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .stroke(.gray.opacity(0.3), lineWidth: 1)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    
                    // Gallary
                    VStack {
                        HStack(alignment: .center) {
                            Text("Gallary")
                                .font(.system(size: 16, weight: .bold))
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                            FButton(action: {
                                
                            }, buttonType: .link, text: "See all")
                            .bold()
                        }
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 8),
                            GridItem(.flexible(), spacing: 8)
                        ], spacing: 8) {
                            if let pictures = viewModel.profile?.profilePictures {
                                ForEach(pictures, id: \.self) { picture in
                                    GeometryReader { geo in
                                        AsyncImage(url: URL(string: picture)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geo.size.width, height: 190)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .clipped()
                                        } placeholder: {
                                            Rectangle()
                                                .fill(.gray)
                                                .frame(width: geo.size.width, height: 190)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        }
                                    }
                                    .frame(height: 190)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 90)
            }
        }
        .ignoresSafeArea()
        .task {
            viewModel.fetchProfile(profileId: profileId)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProfileScreen(profileId: "", isSelfProfile: false)
}
