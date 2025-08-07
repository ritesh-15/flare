import SwiftUI

struct MobileNumberScreen: View {
    
    @ObservedObject var viewModel = MobileNumberViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("My Mobile")
                .font(.system(size: 34, weight: .bold))
            
            Text("Please enter your valid phone number. We will send you a 4-digit code to verify your account.")
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.leading)
            
            VStack(spacing: 64) {
                HStack {
                    Menu {
                        ForEach(MobileNumberViewModel.countries) { country in
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

                    TextField("Mobile number", text: $viewModel.mobileNumber)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                        .tint(.brandPrimary)
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                }
                
                FButton(action: {
                    
                }, text: "Continue")
            }
            .padding(.top, 32)
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .padding(40)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.selectedCountry = MobileNumberViewModel.countries.first
        }
    }
}

#Preview {
    MobileNumberScreen()
}
