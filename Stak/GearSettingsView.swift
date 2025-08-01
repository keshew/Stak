import SwiftUI

struct GearSettingsView: View {
    @StateObject var gearSettingsModel = GearSettingsViewModel()
    
    var body: some View {
        ZStack {
            backgroundColor
            
//            ImageEmitterView(imageName: "imim")
            
            ScrollView {
                VStack {
                    titleText
//                    userInfoSection
//                    preferencesHeader
                    preferencesSection
                }
                .padding(.top)
            }
            .scrollDisabled(UIScreen.main.bounds.width > 380 ? true : false)
        }
    }
}

private extension GearSettingsView {
    
    var backgroundColor: some View {
        LinearGradient(
            colors: [
                Color(red: 245/255, green: 247/255, blue: 250/255),
                Color(red: 235/255, green: 238/255, blue: 242/255)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    var titleText: some View {
        Text("Settings")
            .PoppinsBold(size: 18, color: Color(red: 44/255, green: 62/255, blue: 80/255))
    }
    
//    var userInfoSection: some View {
//        Rectangle()
//            .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
//            .overlay {
//                RoundedRectangle(cornerRadius: 16)
//                    .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
//                    .overlay {
//                        HStack {
//                            userIcon
//                            userInfoTexts
//                            Spacer()
//                        }
//                        .padding(.leading)
//                    }
//            }
//            .frame(height: 108)
//            .cornerRadius(16)
//            .padding(.horizontal, 20)
//            .padding(.top)
//    }
//    
//    var userIcon: some View {
//        Circle()
//            .fill(Color(red: 52/255, green: 152/255, blue: 219/255))
//            .frame(width: 64, height: 64)
//            .overlay {
//                Image(systemName: "figure.soccer")
//                    .font(.system(size: 30))
//                    .foregroundStyle(.white)
//            }
//    }
//    
//    var userInfoTexts: some View {
//        VStack(alignment: .leading) {
//            Text("Gear Master")
//                .PoppinsBold(size: 20)
//            
//            Text("Level 1 • 450 XP")
//                .Poppins(size: 14, color: Color(red: 182/255, green: 188/255, blue: 196/255))
//            
//            HStack {
//                ProgressBarView2(currentValue: CGFloat(UserDefaultsManager().getPoints()))
//                
//                let points = UserDefaultsManager().getPoints()
//                Text("\(points / 5)%")
//                    .Poppins(size: 14, color: Color(red: 182/255, green: 188/255, blue: 196/255))
//                    .padding(.trailing, 50)
//                    .padding(.leading, 5)
//            }
//        }
//        .padding(.leading, 5)
//    }
    
    var preferencesHeader: some View {
        HStack {
            Text("Preferences")
                .PoppinsBold(size: 16)
                .padding(.leading, 20)
            Spacer()
        }
        .padding(.top)
    }
    
    var preferencesSection: some View {
        VStack(spacing: 20) {
            preferenceToggle(
                iconName: "iphone.homebutton",
                iconColor: Color(red: 52/255, green: 152/255, blue: 219/255).opacity(0.3),
                title: "Vibration",
                subtitle: "Haptic feedback",
                isOn: $gearSettingsModel.vibration
            )
            
            preferenceToggle(
                iconName: "speaker.wave.3.fill",
                iconColor: Color(red: 52/255, green: 152/255, blue: 219/255).opacity(0.3),
                title: "Sound Effects",
                subtitle: "App interaction sounds",
                isOn: $gearSettingsModel.sound
            )
            
            preferenceToggle(
                iconName: "music.note",
                iconColor: Color(red: 52/255, green: 152/255, blue: 219/255).opacity(0.3),
                title: "Music",
                subtitle: "App interaction music",
                isOn: $gearSettingsModel.music
            )
        }
        .padding(.horizontal, 20)
        .padding(.top)
    }
    
    @ViewBuilder
    func preferenceToggle(iconName: String, iconColor: Color, title: String, subtitle: String, isOn: Binding<Bool>) -> some View {
        Rectangle()
            .fill(.white)
        
                    .overlay {
                        HStack {
                            Circle()
                                .fill(iconColor)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: iconName)
                                        .foregroundStyle(Color(red: 52/255, green: 152/255, blue: 219/255))
                                }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(title)
                                    .Poppins(size: 14, color: .black.opacity(0.75))
                                
                                Text(subtitle)
                                    .Poppins(size: subtitle.count > 15 ? 11 : 12, color: Color(red: 182/255, green: 188/255, blue: 196/255))
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.leading, 5)
                            
                            Toggle("", isOn: isOn)
                                .toggleStyle(CustomToggleStyle())
                        }
                        .padding(.horizontal)
                    }
           
            .frame(height: 74)
            .cornerRadius(16)
            .shadow(radius: 6)
    }
}

#Preview {
    GearSettingsView()
}


struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 149/255, green: 165/255, blue: 166/255))
                .frame(width: 48, height: 24)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 11 : -11)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct ProgressBarView2: View {
    let maxWidth: CGFloat = UIScreen.main.bounds.width > 900 ? 960 : (UIScreen.main.bounds.width > 600 ? 760 : 340)
    let maxValue: CGFloat = 500
    var currentValue: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 149/255, green: 165/255, blue: 166/255))
                .frame(height: 8)
                .cornerRadius(16)

            Rectangle()
                .fill(Color(red: 52/255, green: 152/255, blue: 219/255))
                .frame(width: (currentValue / maxValue) * maxWidth, height: 8)
                .cornerRadius(16)
                .animation(.easeInOut, value: currentValue)
        }
    }
} 
