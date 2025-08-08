import Foundation
import SwiftUI

struct SwipeActionIndicatorView: View {
    
    @Binding var xoffset: CGFloat
    let screenCutoff: CGFloat
    
    var body: some View {
        VStack(alignment: .center) {
            ActionIconButton(imageName: "heart.fill",
                             backgroundColor: .white,
                             imageIconColor: .brandPrimary,
                             circleFrame: .init(width: 80, height: 80),
                             imageFrame: .init(width: 34, height: 34)) {
                
            }
                             .opacity(Double(xoffset / screenCutoff))
            
            ActionIconButton(imageName: "xmark",
                             backgroundColor: .white,
                             imageIconColor: .brandPrimary,
                             circleFrame: .init(width: 80, height: 80),
                             imageFrame: .init(width: 34, height: 34)) {
                
            }
                             .opacity(Double(xoffset / screenCutoff) * -1)
        }
        .frame(width: 350, height: 450)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    SwipeActionIndicatorView(
        xoffset: .constant(20), screenCutoff: 1
    )
}
