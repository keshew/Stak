import SwiftUI

class GearOnboardingViewModel: ObservableObject {
    let contact = GearOnboardingModel()
    @Published var currentIndex = 0
    @Published var isTab = false
} 