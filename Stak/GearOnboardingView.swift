import SwiftUI

struct GearOnboardingView: View {
    @StateObject var gearOnboardingModel = GearOnboardingViewModel()
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            onboardingImage
            
            contentScrollView
        }
        .fullScreenCover(isPresented: $gearOnboardingModel.isTab) {
            GearTabBarView()
        }
       
    }
}

private extension GearOnboardingView {
    
    var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 52/255, green: 152/255, blue: 219/255),
                Color(red: 41/255, green: 128/255, blue: 185/255)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    var onboardingImage: some View {
        let index = gearOnboardingModel.currentIndex
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let width: CGFloat = {
            if index != 2 {
                if screenWidth > 900 { return 560 }
                else if screenWidth > 600 { return 460 }
                else { return index == 0 ? 380 : 300  }
            } else {
                if screenWidth > 900 { return 560 }
                else if screenWidth > 600 { return 460 }
                else { return 280 }
            }
        }()
        
        let height: CGFloat = {
            if index != 2 {
                if screenWidth > 900 { return 1000 }
                else if screenWidth > 600 { return 800 }
                else { return 500 }
            } else {
                if screenWidth > 900 { return 560 }
                else if screenWidth > 600 { return 460 }
                else { return 320 }
            }
        }()
        
        let position: CGPoint = {
            if index != 2 {
                return CGPoint(x: screenWidth / 2, y: screenHeight / 2.1)
            } else {
                return CGPoint(x: screenWidth / 2, y: screenHeight / 4)
            }
        }()
        
        return Image(systemName: gearOnboardingModel.contact.arrayOfImageOnb[index])
            .resizable()
            .frame(width: width, height: height)
            .position(position)
            .foregroundStyle(.white.opacity(0.9))
    }
    
    var contentScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 38) {
                onboardingTextSection
                nextButtonSection
            }
            .padding(.vertical)
            .background(backgroundOverlay)
            .padding(.top, contentTopPadding)
        }
        .scrollDisabled(UIScreen.main.bounds.width > 380 ? true : false)
    }
    
    var onboardingTextSection: some View {
        VStack(spacing: 40) {
            Text(gearOnboardingModel.contact.arrayOfTitleText[gearOnboardingModel.currentIndex])
                .PoppinsBold(size: 24)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            horizontalItemsScroll
        }
    }
    
    var horizontalItemsScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -20) {
                ForEach(0..<gearOnboardingModel.contact.arrayOfItemText.count, id: \.self) { index in
                    itemView(for: index)
                }
            }
        }
    }
    
    func itemView(for index: Int) -> some View {
        Rectangle()
            .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
            .overlay {
                HStack {
                    Image(systemName: gearOnboardingModel.contact.arrayOfImageItem[index])
                        .resizable()
                        .frame(width: index <= 1 ? 20 : 16, height: 20)
                        .foregroundStyle(.white)
                    
                    Text(gearOnboardingModel.contact.arrayOfItemText[index])
                        .Poppins(size: 13)
                }
            }
            .frame(width: 123, height: 54)
            .cornerRadius(56)
            .padding(.horizontal)
    }
    
    var nextButtonSection: some View {
        
        Button(action: nextButtonAction) {
            Rectangle()
                .fill(Color(red: 52/255, green: 152/255, blue: 219/255))
                .overlay {
                    HStack {
                        Text(gearOnboardingModel.currentIndex != 2 ? "Next" : "Start")
                            .Poppins(size: 16)
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                }
                .frame(height: 56)
                .cornerRadius(16)
                .padding(.horizontal, 40)
                .shadow(color: .white.opacity(0.1), radius: 10, y: 10)
        }
    }
    
    func nextButtonAction() {
        if gearOnboardingModel.currentIndex <= 1 {
            withAnimation {
                gearOnboardingModel.currentIndex += 1
            }
        } else {
            gearOnboardingModel.isTab = true
        }
    }
    
    var backgroundOverlay: some View {
        VStack(spacing: 0) {
            Color(red: 41/255, green: 128/255, blue: 185/255)
                .blur(radius: 10)
                .opacity(0.8)
            
            Color(red: 41/255, green: 128/255, blue: 185/255)
                .blur(radius: 10)
        }
    }
    
    var contentTopPadding: CGFloat {
        let index = gearOnboardingModel.currentIndex
        let screenWidth = UIScreen.main.bounds.width
        
        if index != 2 {
            if screenWidth > 900 { return 1060 }
            else if screenWidth > 600 { return 890 }
            else if screenWidth > 430 { return 560 }
            else { return 460 }
        } else {
            if screenWidth > 900 { return 1050 }
            else if screenWidth > 600 { return 890 }
            else if screenWidth > 430 { return 560 }
            else { return 493 }
        }
    }
}

#Preview {
    GearOnboardingView()
} 
