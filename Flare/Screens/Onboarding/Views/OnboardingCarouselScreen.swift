import SwiftUI

struct OnboardingCarouselScreen: View {
    
    @ObservedObject private var viewModel = OnboardingCarouselViewModel()
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentSelectedIndex) {
                ForEach(0..<viewModel.carouselItems.count, id: \.self) { index in
                    Image(viewModel.carouselItems[index].imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 370, minHeight: 500)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .frame(height: 500)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))

            VStack(alignment: .center, spacing: 10) {
                Text(viewModel.carouselItems[viewModel.currentSelectedIndex].title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.brandPrimary)
                
                Text(viewModel.carouselItems[viewModel.currentSelectedIndex].description)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .regular))
            }
            .padding(.top, 22)
            .padding(.horizontal, 40)
            
            VStack(spacing: 20) {
                Button {
                    
                } label: {
                    Text("Create an account")
                        .frame(width: 300, height: 25)
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(Color.brandPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Already have an account ?")
                    
                    Button {
                        
                    } label: {
                        Text("Sign In")
                            .foregroundStyle(Color.brandPrimary)
                            .fontWeight(.bold)
                    }
                    
                }
            }
            .padding(.top, 42)
            
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom)
    }
}

#Preview {
    OnboardingCarouselScreen()
}
