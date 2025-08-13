import SwiftUI

struct CardModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let locationDistance: Int
    let imageName: String
    let jobRole: String
}

struct DiscoverScreen: View {
    
    @StateObject private var viewModel = DiscoverViewModel(profileService: ProfileService())
    
    var body: some View {
        VStack(alignment: .center) {
            // Navigation bar
            HStack {
                FIconButton(systemImagename: "chevron.left") {
                    
                }
                .tint(.brandPrimary)
                
                Spacer()
                
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
            .padding(.horizontal, 24)
            
            ScrollView(showsIndicators: false) {
                if viewModel.isFetching {
                    ProgressView()
                } else if viewModel.cards.count == 0 {
                    EmptyCardsView()
                } else {
                    VStack(spacing: 40) {
                        // Cards
                        ZStack {
                            ForEach(Array(viewModel.cards.enumerated()), id: \.offset) { index, card in
                                CardView(
                                    card: card,
                                    index: index,
                                    viewModel: viewModel)
                            }
                        }
                        .animation(.spring(), value: viewModel.cards)
                        
                        // Actions
                        HStack(alignment: .center, spacing: 20) {
                            
                            ActionIconButton(
                                imageName: "xmark",
                                backgroundColor: .white,
                                imageIconColor: .orange) {
                                    
                                }
                            
                            ActionIconButton(
                                imageName: "heart.fill",
                                backgroundColor: .brandPrimary,
                                imageIconColor: .white,
                                circleFrame: .init(width: 90, height: 90),
                                imageFrame: .init(width: 32, height: 32)) {
                                    
                                }
                            
                            ActionIconButton(
                                imageName: "star.fill",
                                backgroundColor: .white,
                                imageIconColor: .purple) {
                                    
                                }
                        }
                        .padding(.top, 24)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(maxWidth: .infinity)
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity)
    }
}

struct EmptyCardsView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 8) {
                Text("You're All Caught Up!")
                    .font(.title)
                    .bold()
                
                Text("You’ve reached the end of the profiles. Why not grab a coffee while we find your next match?")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    DiscoverScreen()
}
