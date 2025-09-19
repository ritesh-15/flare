import SwiftUI

struct MobileOrEmailAuthenticationScreen: View {

    @EnvironmentObject private var viewModel: OnboardingViewModel
    @EnvironmentObject private var router: Router
    
    var with: AutheticationWith

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

            VStack(alignment: .leading, spacing: 8) {
                Text(with == .mobile ? "My Mobile" : "Email address")
                    .font(.system(size: 34, weight: .bold))
                
                Text(with == .mobile ? "Please enter your valid phone number. We will send you a 4-digit code to verify your account."
                     : "Please enter your valid email address. We will send you a 4-digit code to verify your account.")
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.leading)
                
                VStack(spacing: 64) {
                    if with == .mobile {
                        HStack {
                            Menu {
                                ForEach(MobileOrEmailAuthenticationViewModel.countries) { country in
                                    Button {
                                        viewModel.selectedCountry = country
                                    } label: {
                                        Label("\(country.flag) (\(country.name))", systemImage: "")
                                            .labelStyle(.titleOnly)
                                    }
                                }
                            } label: {
                                HStack {
                                    if let selected = viewModel.selectedCountry {
                                        Text("\(selected.flag) (\(selected.name))")
                                    } else {
                                        Text("+0")
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding(.trailing, 18)
                                .frame(maxWidth: 120)
                                .cornerRadius(8)
                            }
                            .tint(.brandPrimary)
                            
                            TextField("Mobile number", text: $viewModel.inputText)
                                .keyboardType(.phonePad)
                                .textContentType(.telephoneNumber)
                                .tint(.brandPrimary)
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        }
                    } else {
                        TextField("Email address", text: $viewModel.inputText)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .tint(.brandPrimary)
                            .padding()
                            .textCase(.lowercase)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            }
                    }
                    
                    FButton(action: {
                        if viewModel.canGoToOtpInputScreen(authenticationWith: with) {
                            router.navigate(to: .otpInput)
                        }
                    }, text: "Continue")
                }
                .padding(.top, 32)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.top, 24)
            .onAppear {
                viewModel.selectedCountry = MobileOrEmailAuthenticationViewModel.countries.first
            }
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden(true)
        .toastView(toast: $viewModel.toast)
    }
}

#Preview {
    MobileOrEmailAuthenticationScreen(with: .mobile)
}
