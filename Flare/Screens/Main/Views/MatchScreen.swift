import SwiftUI

struct MatchScreen: View {

    let matchByImageURL: String
    let matchToImageURL: String

    @EnvironmentObject var router: Router

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                VStack {
                    // You can adapt sizes based on available height if needed
                    let availableHeight = geo.size.height
                    // Scale image height/padding a bit for very small screens
                    let imageHeight: CGFloat = availableHeight < 700 ? 200 : 340
                    let topPadding: CGFloat = availableHeight < 700 ? 140 : 180

                    AsyncImage(url: URL(string: matchToImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 220, height: imageHeight)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(x: 80, y: 20)
                            .rotationEffect(.degrees(12))
                            .overlay {
                                AsyncImage(url: URL(string: matchByImageURL)) { matchByImage in
                                    matchByImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 220, height: imageHeight)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .offset(x: -80, y: 120)
                                        .rotationEffect(.degrees(-12))
                                } placeholder: {
                                    Rectangle()
                                        .frame(width: 220, height: imageHeight)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .foregroundStyle(.brandPrimary.opacity(0.1))
                                        .offset(x: -80, y: 120)
                                        .rotationEffect(.degrees(-12))
                                        .overlay(alignment: .center) {
                                            ProgressView()
                                        }
                                }
                            }
                    } placeholder: {
                        Rectangle()
                            .frame(width: 220, height: imageHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .foregroundStyle(.brandPrimary.opacity(0.1))
                            .offset(x: 80, y: 20)
                            .rotationEffect(.degrees(12))
                            .overlay(alignment: .center) {
                                ProgressView()
                            }
                    }
                    
                    VStack(spacing: 8) {
                        Text("It's a match!")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.brandPrimary)
                        
                        Text("Start a conversation now with each other")
                            .font(.subheadline)
                    }
                    .padding(.top, topPadding)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        FButton(action: {
                            router.navigate(to: .main)
                        }, text: "Say Hello")
                        
                        FButton(action: {
                            router.navigate(to: .main)
                        }, buttonType: .secondary, text: "Keep swiping")
                    }
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MatchScreen(matchByImageURL: "", matchToImageURL: "")
}
