import SwiftUI

struct WrapperContainer<Content: View>: View {
    
    var shouldShowTopNavBar: Bool = false
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                if shouldShowTopNavBar {
                    TopNavBar()
                       
                }

                content()
            }
            .padding(.horizontal, 32)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    WrapperContainer {
        Text("Hello")
    }
}
