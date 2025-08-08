import SwiftUI

struct CardModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let locationDistance: Int
    let imageName: String
    let jobRole: String
}

struct DiscoverScreen: View {
    
    @State private var cards: [CardModel] = [
        CardModel(name: "Jasica Parker, 23", locationDistance: 12, imageName: "onboarding-1", jobRole: "Product Manager"),
        CardModel(name: "Jasica Parker, 23", locationDistance: 12, imageName: "onboarding-2", jobRole: "Product Manager"),
        CardModel(name: "Jasica Parker, 23", locationDistance: 12, imageName: "onboarding-3", jobRole: "Product Manager")
    ]
    
    @State private var dragOffset: CGSize = .zero
    
    private func index(of card: CardModel) -> Int {
        cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    var body: some View {
        WrapperContainer(shouldShowTopNavBar: true, navbarPage: .main) {
            VStack(spacing: 40) {
                // Cards
                ZStack {
                    ForEach(cards) { card in
                        Card(card: card)
                            .offset(dragOffset)
                            .rotationEffect(.degrees(Double(dragOffset.width / 20)))
                            .gesture(
                                DragGesture()
                                    .onChanged{ value in
                                        dragOffset = value.translation
                                    }
                                    .onEnded{ value in
                                        if abs(value.translation.width) > 100 {
                                            withAnimation {
                                                cards.removeAll {
                                                    $0.id == card.id
                                                }
                                            }
                                        }
                                        dragOffset = .zero
                                    }
                            )
                    }
                }
                .animation(.spring(), value: cards)
                
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
        }
    }
}

#Preview {
    DiscoverScreen()
}
