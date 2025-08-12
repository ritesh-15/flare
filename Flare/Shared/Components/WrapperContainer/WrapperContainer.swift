import SwiftUI

// @Deprecated
struct WrapperContainer<Content: View>: View {
    
    var shouldShowTopNavBar: Bool = false
    var navbarPage: NavbarPage = .onboarding
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            if shouldShowTopNavBar {
                TopNavBar(navbarPage: navbarPage)
            }

            ScrollView(showsIndicators: false) {
                content()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    WrapperContainer {
        Text("Hello")
    }
}
