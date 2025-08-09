import SwiftUI

struct WrapperContainer<Content: View>: View {
    
    var shouldShowTopNavBar: Bool = false
    var navbarPage: NavbarPage = .onboarding
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            if shouldShowTopNavBar {
                TopNavBar(navbarPage: navbarPage)
            }

            ScrollView {
                content()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollBounceBehavior(.basedOnSize)
        }
//        .padding(.horizontal, 24)
    }
}

#Preview {
    WrapperContainer {
        Text("Hello")
    }
}
