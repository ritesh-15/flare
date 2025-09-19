import SwiftUI

struct CardModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let locationDistance: Int
    let imageName: String
    let jobRole: String
}

struct DiscoverScreen: View {

    @StateObject private var viewModel = DiscoverViewModel(
        profileService: ProfileService(),
        matchService: MatchService())
    
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
                    viewModel.toggleFilter()
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
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(maxWidth: .infinity)
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity)
        .refreshable {
            viewModel.getProfiles()
        }
        .sheet(isPresented: $viewModel.showFilters) {
            FiltersScreen()
        }
    }
}

struct EmptyCardsView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 8) {
                Image("find_more")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230, height: 440)

                Text("You're All Caught Up!")
                    .font(.title)
                    .bold()
                
                Text("You’ve reached the end of the profiles. Why not grab a coffee while we find your next match?")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    DiscoverScreen()
}
