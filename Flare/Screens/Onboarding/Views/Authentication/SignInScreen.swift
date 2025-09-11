import SwiftUI

struct SignInScreen: View {
    
    @StateObject var viewModel = SignInViewModel()
    @EnvironmentObject var router: Router
    @State var emailAddress: String = ""
    @State var password: String = ""

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
                        Text("Welcome back!")
                            .font(.title)
                            .bold()
                        
                        Text("Let's find you a new date, but first sign in to Flare application")
                            .font(.body)
                            .fontWeight(.regular)
                    }
                    
                    VStack(spacing: 12) {
                        TextField("Email address", text: $emailAddress)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .tint(.brandPrimary)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            }
                        
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .tint(.brandPrimary)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            }
                        
                        FButton(action: {
                            viewModel.login(email: emailAddress, password: password)
                        }, text: "Sign In")
                    }
                    .padding(.top, 40)
                    
                    VStack(alignment: .center, spacing: 8) {
                        Text("Didn't remember your password?")
                            .font(.body)
                        
                        FButton(action: {
                            
                        }, buttonType: .link, text: "Forgot password")
                    }
                    .padding(.top, 24)
                }
            }
            .padding(.top, 24)
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
        .toastView(toast: $viewModel.toast)
        .onAppear {
            viewModel.router = router
        }
    }
}

#Preview {
    SignInScreen()
}
