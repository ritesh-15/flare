import SwiftUI

struct ActionIconButton: View {
    
    var imageName: String
    var backgroundColor: Color
    var imageIconColor: Color
    var circleFrame: CGSize = .init(width: 60, height: 60)
    var imageFrame: CGSize = .init(width: 22, height: 22)
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .fill(backgroundColor)
                    .frame(width: circleFrame.width, height: circleFrame.height)
                    .shadow(color: .black.opacity(0.1), radius: 5)
                
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageFrame.width, height: imageFrame.height)
                    .tint(imageIconColor)
                    .bold()
                    .padding()
            }
        }
    }
}

#Preview {
    ActionIconButton(imageName: "xmark", backgroundColor: .white, imageIconColor: .yellow) {
        
    }
}
