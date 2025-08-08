import SwiftUI

struct TopNavBar: View {
    
    @EnvironmentObject var router: Router

    var body: some View {
        HStack {
            FIconButton(systemImagename: "chevron.left") {
                router.navigateBack()
            }
            .tint(.brandPrimary)
        }
    }
}

#Preview {
    TopNavBar()
}
