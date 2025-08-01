import SwiftUI

class GearHomeViewModel: ObservableObject {
    private let model = GearHomeModel()
    @Published var isProgress = false
} 