import SwiftUI

class GearSettingsViewModel: ObservableObject {
    let contact = GearSettingsModel()
    @ObservedObject private var soundManager = SoundManager.shared
    
    @Published var sound: Bool {
        didSet {
            UserDefaults.standard.set(sound, forKey: "sound")
            soundManager.toggleSound()
        }
    }
    
    @Published var music: Bool {
        didSet {
            UserDefaults.standard.set(music, forKey: "music")
            soundManager.toggleMusic()
        }
    }
    
    @Published var vibration: Bool {
        didSet {
            UserDefaults.standard.set(vibration, forKey: "vibration")
        }
    }
    
    init() {
        self.vibration = UserDefaults.standard.bool(forKey: "vibration")
        self.sound = UserDefaults.standard.bool(forKey: "sound")
        self.music = UserDefaults.standard.bool(forKey: "music")
    }
    
} 