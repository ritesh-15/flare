import SwiftUI

struct MatchesScreen: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 9) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Matches")
                            .font(.title)
                            .bold()
                    }
                    
                    Spacer()
                    
                    FIconButton(systemImagename: "sparkle") {
                        
                    }
                    .tint(.brandPrimary)
                }
                
                Text("This is a list of people who have liked you and your matches.")
                    .font(.body)
                    .fontWeight(.regular)
            }
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(1..<10) { _ in
                        ZStack(alignment: .bottom) {
                            Image("onboarding-2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width - (24 * 2) - 12) / 2, height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                            
                            VStack(alignment: .center, spacing: 8) {
                                Text("Leaini, 19")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                
                                ZStack {
                                    Rectangle()
                                        .fill(.black.opacity(0.3))
                                        .frame(height: 50)
                                        .blur(radius: 10)
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundStyle(.white)
                                            .bold()
                                            .frame(width: 20, height: 20)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "heart.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundStyle(.white)
                                            .bold()
                                            .frame(width: 20, height: 20)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .frame(width: (UIScreen.main.bounds.width - (24 * 2) - 12) / 2, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    MatchesScreen()
}
