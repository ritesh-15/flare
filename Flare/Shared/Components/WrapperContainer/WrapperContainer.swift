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
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    WrapperContainer {
        Text("Hello")
    }
}
