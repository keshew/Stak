import SwiftUI

struct GearHomeView: View {
    @StateObject var viewModel = GearHomeViewModel()
    @Binding var selectedTab: CustomTabBar.TabType
    @ObservedObject private var soundManager = SoundManager.shared
    @State private var isShowingGame = false
    @State private var isShowingNote = false
    
    @StateObject private var surveyVM = SurveyViewModel()
    
    var body: some View {
          Group {
              if !surveyVM.isCompleted {
                  SurveyView(vm: surveyVM)
              } else {
                  mainContent
              }
          }
          .fullScreenCover(isPresented: $viewModel.isProgress) {
              GearProgressView()
          }
      }

      var mainContent: some View {
          ZStack {
              backgroundColor


              mainScrollView
          }
    }
}

private extension GearHomeView {
    
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
    
    var mainScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 25) {
                headerSection
//                progressCard
                quickAccessSection
                
                Color.clear.frame(height: 100)
            }
            .padding(.top, 20)
        }
    }
    
    var headerSection: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome back!")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                    
                    Text("Ready to care for your gear?")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                }
                
                Spacer()
                
                Circle()
                    .fill(Color(red: 52/255, green: 152/255, blue: 219/255))
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: "figure.soccer")
                            .font(.system(size: 24))
                            .foregroundStyle(.white)
                    }
            }
            .padding(.horizontal, 20)
        }
    }
    
    var progressCard: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Progress")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                    
                    Text("Level 3 • 750 XP")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color(red: 52/255, green: 152/255, blue: 219/255).opacity(0.2), lineWidth: 8)
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .stroke(Color(red: 52/255, green: 152/255, blue: 219/255), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 60, height: 60)
                        .rotationEffect(.degrees(-90))
                    
                    Text("75%")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(red: 52/255, green: 152/255, blue: 219/255))
                }
            }
            
            // Level indicators in a different style
            HStack(spacing: 15) {
                levelIndicator(
                    level: "Beginner",
                    isActive: false,
                    isCompleted: true
                )
                
                levelIndicator(
                    level: "Intermediate", 
                    isActive: false,
                    isCompleted: true
                )
                
                levelIndicator(
                    level: "Advanced",
                    isActive: true,
                    isCompleted: false
                )
                
                levelIndicator(
                    level: "Expert",
                    isActive: false,
                    isCompleted: false
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 20)
    }
    
    func levelIndicator(level: String, isActive: Bool, isCompleted: Bool) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isCompleted ? Color(red: 52/255, green: 152/255, blue: 219/255) : 
                          isActive ? Color(red: 52/255, green: 152/255, blue: 219/255).opacity(0.3) : 
                          Color(red: 236/255, green: 240/255, blue: 241/255))
                    .frame(width: 40, height: 40)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                } else if isActive {
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 52/255, green: 152/255, blue: 219/255))
                }
            }
            
            Text(level)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isActive ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 149/255, green: 165/255, blue: 166/255))
        }
    }
    
    var quickAccessSection: some View {
        VStack(spacing: 10) {
//            HStack {
//                Text("Quick Actions")
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
//                
//                Spacer()
//            }
//            .padding(.horizontal, 20)
            
//            HStack(spacing: 15) {
//                quickAccessItemHorizontal(
//                    icon: "note.text",
//                    title: "Notes",
//                    color: Color(red: 231/255, green: 76/255, blue: 60/255),
//                    action: { isShowingNote = true }
//                )
//                
//                quickAccessItemHorizontal(
//                    icon: "newspaper",
//                    title: "News",
//                    color: Color(red: 52/255, green: 73/255, blue: 94/255),
//                    action: { isShowingGame = true }
//                )
//            }
//            .padding(.horizontal, 20)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 15) {
                quickAccessItem(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Progress",
                    subtitle: "Track maintenance",
                    color: Color(red: 52/255, green: 152/255, blue: 219/255),
                    action: { viewModel.isProgress = true }
                )
                
                quickAccessItem(
                    icon: "book.closed.fill",
                    title: "Guide",
                    subtitle: "Care instructions",
                    color: Color(red: 46/255, green: 204/255, blue: 113/255),
                    action: { selectedTab = .Guide }
                )
                
                quickAccessItem(
                    icon: "newspaper",
                    title: "News",
                    subtitle: "Get all sport news",
                    color: Color(red: 155/255, green: 89/255, blue: 182/255),
                    action: { selectedTab = .Quiz }
                )
                
                quickAccessItem(
                    icon: "gearshape.fill",
                    title: "Settings",
                    subtitle: "Preferences",
                    color: Color(red: 230/255, green: 126/255, blue: 34/255),
                    action: { selectedTab = .Profile }
                )
            }
            .padding(.horizontal, 20)
            
            // Bottom row with different style
      
        }
        .fullScreenCover(isPresented: $isShowingNote) {
            GearCareNoteView()
        }
        .fullScreenCover(isPresented: $isShowingGame) {
            GearSortingView()
        }
    }
    
    @ViewBuilder
    func quickAccessItem(icon: String, title: String, subtitle: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(color)
                }
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                    
                    Text(subtitle)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                        .multilineTextAlignment(.center)
                }
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    func quickAccessItemHorizontal(icon: String, title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 15) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.1))
                        .frame(width: 45, height: 45)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(color)
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    GearHomeView(selectedTab: .constant(.Home))
} 
