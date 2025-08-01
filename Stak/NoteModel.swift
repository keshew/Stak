import SwiftUI

struct NoteModel: Codable, Identifiable, Equatable {
    var id = UUID()
    var imageName: String
    var title: String
    var category: String
    var instruction: String
    var isFav: Bool
    var date = Date()
} 