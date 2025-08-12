import SwiftUI

struct OnboardingCarouselScreen: View {
    
    @EnvironmentObject private var router: Router
    @ObservedObject private var viewModel = OnboardingCarouselViewModel()
    
    var body: some View {
        VStack {
            // Image carousel
            TabView(selection: $viewModel.currentSelectedIndex) {
                ForEach(0..<OnboardingCarouselViewModel.carouselItems.count, id: \.self) { index in
                    Image(OnboardingCarouselViewModel.carouselItems[index].imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 370, height: 450)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .frame(height: 450)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            
            // Carousel text
            VStack(alignment: .center, spacing: 10) {
                Text(OnboardingCarouselViewModel.carouselItems[viewModel.currentSelectedIndex].title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.brandPrimary)
                
                Text(OnboardingCarouselViewModel.carouselItems[viewModel.currentSelectedIndex].description)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .regular))
            }
            .padding(.top, 22)
            
            // Action buttons
            VStack(spacing: 20) {
                FButton(action: {
                    router.navigate(to: .signup)
                }, text: "Create an account")
                
                HStack {
                    Text("Already have an account ?")
                        .fontWeight(.light)
                    
                    FButton(action: {
                        router.navigate(to: .signin)
                    }, buttonType: .link, text: "Sign In")
                }
            }
            .padding(.top, 42)
            
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnboardingCarouselScreen()
}
