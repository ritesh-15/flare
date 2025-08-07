import SwiftUI

enum FButtonType {
    case primary
    case secondary
    case link
}

struct FButton: View {
    
    var action: () -> Void
    var buttonType: FButtonType = .primary
    var text: String
    
    var body: some View {
        Button {
            action()
        } label: {
            switch buttonType {
            case .primary:
                Text(text)
                    .frame(width: 300, height: 25)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.brandPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .fontWeight(.bold)
            case .secondary:
                Text(text)
                    .frame(width: 300, height: 25)
                    .padding()
                    .foregroundStyle(.brandPrimary)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                    }
                    
            case .link:
                Text(text)
                    .foregroundStyle(Color.brandPrimary)
            }
        }
    }
}

#Preview {
    FButton(action: {
        
    }, buttonType: .secondary, text: "Create a new account")
}
