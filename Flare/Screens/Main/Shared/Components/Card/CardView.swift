import Foundation
import SwiftUI

struct CardView: View {
    
    let card: ProfileCardModel
    let index: Int
    @State var xOffset: CGFloat = 0
    @State var degrees: Double = 0
    @ObservedObject var viewModel: DiscoverViewModel
    @EnvironmentObject var router: Router
    
    var topPictureURL: String {
        guard card.profilePictures.count > 0 else {
            return ""
        }
        
        return card.profilePictures.first ?? ""
    }
    
    var body: some View {
        ZStack {
            ZStack {
                AsyncImage(url: URL(string: topPictureURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 450)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 350, height: 450)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                SwipeActionIndicatorView(xoffset: $xOffset, screenCutoff: screenCutoff)
            }
            
            VStack(alignment: .leading) {
                if index != 1 {
                    Label("12 km", systemImage: "location.fill")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.all, 8)
                        .background(.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                }
                
                Spacer()
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.1))
                        .blur(radius: 5)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading) {
                        Text(card.firstName)
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                        
                        Text(card.position)
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
                .frame(height: 80)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 350, height: 450)
        .offset(x: xOffset, y: index != 1 ? 20 : 0)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .gesture(
            DragGesture()
                .onChanged{ value in
                    onDragChange(value)
                }
                .onEnded{ value in
                    onDragEnded(value)
                }
        )
        .onTapGesture {
            router.navigate(to: .profileDetail(profileId: card.id))
        }
    }
}

private extension CardView {
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        
        if abs(width) <= abs(screenCutoff) {
            // Return to center
            xOffset = 0
            degrees = 0
            return
        }
        
        if width > screenCutoff {
            withAnimation {
                // Swipe right
                xOffset = 500
                degrees = 12
            } completion: {
                viewModel.swipeRight(card: card, index: index)
            }

        } else {
            withAnimation {
                // Swipe left
                xOffset = -500
                degrees = -12
            } completion: {
                viewModel.swipeLeft(card: card, index: index)
            }
        }
    }
    
    func onDragChange(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width / 25)
    }
}

private extension CardView {
    
    var screenCutoff: CGFloat {
        (UIScreen.main.bounds.width / 2) * 0.8
    }
}

#Preview {
    CardView(
        card: ProfileCardModel(
            id: "dfdfdfer",
            firstName: "Ritesh",
            lastName: "Khore",
            position: "Software engineer",
            gender: .male,
            birthDate: Date(),
            profilePictures: [],
            interests: [],
            userId: "",
            location: "",
            distance: 1,
            about: ""),
        index: 0,
        viewModel: DiscoverViewModel(profileService: ProfileService(), matchService: MatchService())
    )
}
