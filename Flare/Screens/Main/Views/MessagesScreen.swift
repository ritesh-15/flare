import SwiftUI

struct MessagesScreen: View {
    
    @EnvironmentObject var router: Router
    @State var searchText = ""
    
    var body: some View {
        VStack {
            VStack {
                // Messages Header
                HStack(alignment: .center) {
                    Text("Messages")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    FIconButton(systemImagename: "line.3.horizontal.decrease.circle") {
                        
                    }
                    .tint(.brandPrimary)
                }
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .autocorrectionDisabled()
                        .tint(.brandPrimary)
                }
                .cornerRadius(10)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                }
            }
            .padding(.bottom, 10)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    // Activities
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Activities")
                            .font(.title3)
                            .bold()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center) {
                                ForEach(1..<10) { index in
                                    ActivityView()
                                }
                            }
                            .padding(.horizontal, 4)
                            .padding(.top, 4)
                        }
                    }
                    
                    // Messages
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Messages")
                            .font(.title3)
                            .bold()
                        
                        LazyVStack {
                            ForEach(1..<10) { _ in
                               MessageView()
                                    .onTapGesture {
                                        router.navigate(to: MessagesRoutes
                                            .thread)
                                    }
                            }
                        }
                    }
                    .padding(.top, 10)
                }
            }.scrollBounceBehavior(.basedOnSize)
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
    }
}

struct MessageView: View {
    
    var body: some View {
        HStack {
            ActivityView(shouldShowName: false, width: 48, height: 48)
            
            VStack(spacing: 6) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Emellie")
                            .font(.headline)
                        
                        Text("hey whatsapp")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("23 min")
                            .font(.caption2)
                            .fontWeight(.light)
                        
                        Circle()
                            .fill(.brandPrimary)
                            .frame(width: 16, height: 16)
                            .overlay {
                                Text("2")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 12))
                            }
                    }
                }
                
                Divider()
            }
        }
        .padding(.horizontal, 4)
    }
}

struct ActivityView: View {
    
    var shouldShowName: Bool = true
    var width: CGFloat = 64
    var height: CGFloat = 64
    
    var body: some View {
        VStack(alignment: .center) {
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.pink, .orange, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
                .frame(width: width + 8, height: height + 8)
                .overlay(
                    Image("onboarding-3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipShape(Circle())
                )
            
            if shouldShowName {
                Text("Ava")
                    .font(.system(size: 14, weight: .bold))
                    .bold()
            }
        }
    }
}

#Preview {
    MessagesScreen()
}
