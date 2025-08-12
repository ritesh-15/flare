import Foundation

class OnboardingCarouselViewModel: ObservableObject {
    
    // MARK: - Static fields
    
    static let carouselItems = [
        CarouselItemModel(imageName: "onboarding-1",
                          title: "Algorithm",
                          description: "Users going through a vetting process to ensure you never match with bots."),
        CarouselItemModel(imageName: "onboarding-2",
                          title: "Matches",
                          description: "We match you with people that have a large array of similar interests."),
        CarouselItemModel(imageName: "onboarding-3",
                          title: "Premium",
                          description: "Sign up today and enjoy the first month of premium benefits on us."),
    ]
    
    // MARK: - States

    @Published var currentSelectedIndex: Int = 0
}
