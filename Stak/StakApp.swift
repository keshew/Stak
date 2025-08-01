import SwiftUI

@main
struct GearCareApp: App {
    @ObservedObject private var soundManager = SoundManager.shared
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().isFirstLaunch() {
                GearOnboardingView()
                    .onAppear() {
                        soundManager.playBackgroundMusic()
                    }
            } else {
                GearTabBarView()
                    .onAppear() {
                        soundManager.playBackgroundMusic()
                        UserDefaultsManager().recordGameLaunchDate()
                    }
            }
        }
    }
} 