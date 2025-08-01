import SwiftUI

struct Gallery: Identifiable, Codable {
    var id = UUID()
    let image: String
    let title: String
    let text: String
    let detailedText: String
    var isDone: Bool
} 