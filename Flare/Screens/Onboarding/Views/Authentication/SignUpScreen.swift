import SwiftUI

struct SignUpScreen: View {
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    FIconButton(systemImagename: "chevron.left") {
                        router.navigateBack()
                    }
                    .tint(.brandPrimary)
                    
                    Spacer()
                }
            }

            ScrollView(showsIndicators: false) {
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 142, height: 142)
                    
                    VStack(spacing: 32) {
                        Text("Sign up to continue")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        FButton(action: {
                            router.navigate(to: .emailOrMobileAuthentication(with: .email))
                        }, text: "Continue with email")
                        
                        FButton(action: {
                            router.navigate(to: .emailOrMobileAuthentication(with: .mobile))
                        }, buttonType: .secondary, text: "Use phone number")
                        .fontWeight(.bold)
                        
                        
                    }
                    .padding(.top, 78)
                    
                    VStack(spacing: 32) {
                        ZStack {
                            Divider()
                            
                            Text("or sign up with")
                                .font(.caption)
                                .padding(.horizontal, 22)
                                .background(Color(.systemBackground))
                        }
                        
                        HStack(spacing: 20) {
                            FIconButton(imageName: "facebook") {
                                
                            }
                            
                            FIconButton(imageName: "apple") {
                                
                            }
                            
                            FIconButton(imageName: "google") {
                                
                            }
                        }
                    }
                    .padding(.top, 64)
                    
                    HStack(spacing: 32) {
                        FButton(action: {
                            
                        }, buttonType: .link, text: "Term of use")
                        .font(.system(size: 14, weight: .regular))
                        
                        FButton(action: {
                            
                        }, buttonType: .link, text: "Privacy policy")
                        .font(.system(size: 14, weight: .regular))
                    }
                    .padding(.top, 76)
                }
                .navigationBarBackButtonHidden(true)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    SignUpScreen()
}
