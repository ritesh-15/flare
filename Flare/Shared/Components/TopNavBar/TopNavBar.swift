import SwiftUI

enum NavbarPage {
    case onboarding
    case main
    case profile
    case messaging
    case matches
}

struct TopNavBar: View {
    
    @EnvironmentObject var router: Router
    var navbarPage: NavbarPage = .onboarding

    var body: some View {
        HStack {
            FIconButton(systemImagename: "chevron.left") {
                router.navigateBack()
            }
            .tint(.brandPrimary)
            
            Spacer()
            
            if navbarPage == .main {
                VStack {
                    Text("Discover")
                        .font(.title)
                        .bold()
                    
                    Text("Mumbai, Maharastra")
                        .font(.callout)
                }
                
                Spacer()
                
                FIconButton(systemImagename: "line.3.horizontal.decrease.circle") {
                    
                }
                .tint(.brandPrimary)
            }
        }
    }
}

#Preview {
    TopNavBar()
}
