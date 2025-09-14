import SwiftUI

struct MatchScreen: View {

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack {
                        Image("onboarding-3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 190, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .clipped()
                            .offset(x: 45)

                        Image("onboarding-1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 190, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .clipped()
                            .offset(x: -45, y: 250)
                    }
                    .background(.red)

                    Spacer()

                    VStack(spacing: 83) {
                        VStack {
                            Text("It's a match Jake!")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.brandPrimary)

                            Text("Start conversation with now with each other")
                        }

                        VStack(spacing: 12) {
                            FButton(action: {

                            }, text: "Say hello")

                            FButton(action: {

                            }, buttonType: .secondary, text: "Keep swiping")
                        }
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    MatchScreen()
}
