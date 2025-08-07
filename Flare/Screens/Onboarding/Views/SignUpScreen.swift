import SwiftUI

struct SignUpScreen: View {
    var body: some View {
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
                    
                }, text: "Continue with email")
                
                FButton(action: {
                    
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
                    IconButton(imageName: "facebook") {
                        
                    }

                    IconButton(imageName: "apple") {
                        
                    }
                    
                    IconButton(imageName: "google") {
                        
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
}

struct IconButton: View {
    
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(imageName)
                .resizable()
                .frame(width: 32, height: 32)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                }
        }
    }
}

#Preview {
    SignUpScreen()
}
