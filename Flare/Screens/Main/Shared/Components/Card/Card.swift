import SwiftUI

struct Card: View {
    
    let card: CardModel
    
    var body: some View {
        ZStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 450)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .clipped()
            
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
    }
}

#Preview {
    Card(
        card: CardModel(name: "test", locationDistance: 12, imageName: "", jobRole: "")
    )
}
