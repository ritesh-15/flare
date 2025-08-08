import Foundation
import SwiftUI

struct CardView: View {
    
    let card: CardModel
    @State var xOffset: CGFloat = 0
    @State var degrees: Double = 0
    
    var body: some View {
        ZStack {
            ZStack {
                Image(card.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 450)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .clipped()
                
                SwipeActionIndicatorView(xoffset: $xOffset, screenCutoff: screenCutoff)
            }
            
            VStack(alignment: .leading) {
                Label("\(card.locationDistance) km", systemImage: "location.fill")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(.all, 8)
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                
                Spacer()
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.1))
                        .blur(radius: 5)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading) {
                        Text(card.name)
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                        
                        Text(card.jobRole)
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
        .offset(x: xOffset)
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
            // Swipe right
            xOffset = 500
            degrees = 12
            
            // TODO: Remove from the list
        } else {
            
            // Swipe left
            xOffset = -500
            degrees = -12
            
            // TODO: Remove from the list
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
        card: CardModel(name: "test", locationDistance: 12, imageName: "onboarding-3", jobRole: "")
    )
}
