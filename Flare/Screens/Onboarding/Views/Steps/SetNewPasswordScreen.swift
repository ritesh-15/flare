import SwiftUI

struct SetNewPasswordScreen: View {
    
    @EnvironmentObject private var viewModel: OnboardingViewModel
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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Lets secure your account")
                            .font(.title)
                            .bold()
                        
                        Text("Please enter a strong password to secure your account from theft")
                            .font(.body)
                            .fontWeight(.regular)
                    }
                    
                    VStack(spacing: 12) {
                        SecureField("Password", text: $viewModel.password)
                            .textContentType(.password)
                            .tint(.brandPrimary)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            }

                        SecureField("Confirm password", text: $viewModel.confirmPassword)
                            .textContentType(.password)
                            .tint(.brandPrimary)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            }
                        
                        FButton(action: {
                            viewModel.canGoToProfileDetailScreen()
                        }, text: "Continue")
                    }
                    .padding(.top, 40)
                    
                }
            }
            .padding(.top, 24)
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
        .toastView(toast: $viewModel.toast)
    }
}

#Preview {
    SetNewPasswordScreen()
}
