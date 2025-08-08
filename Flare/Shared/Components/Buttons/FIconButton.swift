import SwiftUI

struct FIconButton: View {
    
    var imageName: String?
    var systemImagename: String?
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            if let imageName {
                Image(imageName)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                    }
            } else if let systemImagename {
                Image(systemName: systemImagename)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .padding(.all, 12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                    }
            }
        }
    }
}

#Preview {
    FIconButton(systemImagename: "chevron.left") {
        
    }
}
