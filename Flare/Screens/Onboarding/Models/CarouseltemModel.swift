import Foundation

struct CarouselItemModel: Identifiable {
    let id = UUID().uuidString
    let imageName: String
    let title: String
    let description: String
}
