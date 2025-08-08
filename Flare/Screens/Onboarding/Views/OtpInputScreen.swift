import Foundation
import SwiftUI

struct OtpInputScreen: View {
    
    var body: some View {
        WrapperContainer(shouldShowTopNavBar: true) {
            VStack(spacing: 48) {
                VStack(alignment: .center, spacing: 8) {
                    Text("00:43")
                        .font(.system(size: 34, weight: .bold))
                    
                    Text("Type the verification code we have sent to you")
                        .font(.system(size: 18, weight: .regular))
                        .multilineTextAlignment(.center)
                }
                
                OtpInputField()
                
                FButton(action: {
                    
                }, buttonType: .link, text: "Send again")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct OtpInputField: View {
    
    @EnvironmentObject private var router: Router
    @State var inputValues: [String] = Array(repeating: "", count: 4)
    @FocusState private var focusState: Int?
    
    let numberOfFields = 4
    
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                TextField("", text: $inputValues[index])
                    .foregroundStyle(hasInputFilled(index: index) ? .white : .brandPrimary)
                    .tint(hasInputFilled(index: index) ? .white : .brandPrimary)
                    .frame(width: 70, height: 70)
                    .tag(index)
                    .multilineTextAlignment(.center)
                    .background(hasInputFilled(index: index) ? .brandPrimary : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .font(.system(size: 34, weight: .bold))
                    .focused($focusState, equals: index)
                    .onChange(of: inputValues[index]) { _, newValue in
                        if inputValues[index].count > 1 {
                            inputValues[index] = String(inputValues[index].suffix(1))
                        }
                        
                        if !newValue.isEmpty {
                            if index == numberOfFields - 1 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.focusState = nil
                                }
                            } else {
                                self.focusState = (self.focusState ?? 0) + 1
                            }
                        } else {
                            self.focusState = (self.focusState ?? 0) - 1
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(self.focusState == index ? Color.brandPrimary : Color.gray.opacity(0.15), lineWidth: 1)
                    }
            }
        }
    }
    
    init() {
        self.focusState = 0
    }
    
    private func hasInputFilled(index: Int) -> Bool {
        guard let focusState else {
            return false
        }
    
        return focusState > index && !inputValues[index].isEmpty
    }
}

#Preview {
    OtpInputScreen()
}
