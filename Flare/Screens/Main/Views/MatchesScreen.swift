import SwiftUI

struct MatchesScreen: View {
    
    @StateObject private var viewModel = MatchesViewModel(matchService: MatchService())
    
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
                    ForEach(viewModel.matches) { match in
                        MatchCard(match: match, viewModel: viewModel)
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
    }
}

struct MatchCard: View {
    
    var match: MatchModel
    @ObservedObject var viewModel: MatchesViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            AsyncImage(url: URL(string: match.matchTo.profilePictures.first ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width - (24 * 2) - 12) / 2, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .clipped()
                    .overlay(alignment: .topTrailing) {
                        if match.status == .match {
                            ActionIconButton(
                                imageName: "heart.fill",
                                backgroundColor: .white,
                                imageIconColor: .brandPrimary,
                                circleFrame: .init(width: 45, height: 45),
                                imageFrame: .init(width: 22, height: 22)) {
                                    
                                }
                        } else if match.status == .unmatch || match.status == .blocked {
                            ActionIconButton(
                                imageName: "xmark",
                                backgroundColor: .white,
                                imageIconColor: .orange,
                                circleFrame: .init(width: 45, height: 45),
                                imageFrame: .init(width: 22, height: 22)) {
                                    
                                }
                        }
                    }
            } placeholder: {
                Rectangle()
                    .fill(.gray)
                    .frame(width: (UIScreen.main.bounds.width - (24 * 2) - 12) / 2, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .clipped()
            }
            
            VStack(alignment: .center, spacing: 8) {
                Text("\(match.matchTo.firstName), \(23)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                
                ZStack {
                    Rectangle()
                        .fill(.black.opacity(0.3))
                        .frame(height: 50)
                        .blur(radius: 10)
                    
                    if match.status == .pending {
                        HStack {
                            Spacer()
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.white)
                                .bold()
                                .frame(width: 20, height: 20)
                                .onTapGesture {
                                    viewModel.unmatch(matchId: match.id)
                                }
                            
                            Spacer()
                            
                            if match.matchBy.id != viewModel.profileId {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
                                        viewModel.match(matchId: match.id)
                                    }
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .frame(width: (UIScreen.main.bounds.width - (24 * 2) - 12) / 2, height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    MatchesScreen()
}
