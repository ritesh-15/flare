import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack(alignment: .topLeading) {
                    Image("onboarding-2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 410)
                        .clipped()
                    
                    FIconButton(systemImagename: "chevron.left") {
                        router.navigateBack()
                    }
                    .tint(.white)
                    .padding(.top, 64)
                    .padding(.leading, 24)
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .overlay(alignment: .bottom) {
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
                }
                
                VStack(spacing: 30) {
                    // Name and profession detail
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Jessica Parker, 24")
                                .font(.system(size: 24, weight: .bold))
                            
                            Text("Professional Model")
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
                            
                            Text("Mumbai, Maharastra")
                                .font(.system(size: 14, weight: .regular))
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "location")
                            
                            Text("1 Km")
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
                        
                        Text("My name is Jessica Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading..")
                            .font(.system(size: 14, weight: .regular))
                    }
                    
                    // Interestes
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Interests")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.bottom, 10)
                        
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 100, maximum: 150))
                        ], spacing: 8) {
                            ForEach(1..<5) { _ in
                                Text("Music")
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.gray.opacity(0.3), lineWidth: 1)
                                    }
                            }
                        }
                    }
                    
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
                            ForEach(1..<5) { index in
                                let isLarge = index % 3 == 0
                                
                                Image("onboarding-2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: isLarge ? 190 : 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .clipped()
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 90)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileScreen()
}
