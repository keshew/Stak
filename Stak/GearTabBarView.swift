import SwiftUI

struct GearTabBarView: View {
    @StateObject var gearTabBarModel =  GearTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Home

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Home {
                    GearHomeView(selectedTab: $selectedTab)
                } else if selectedTab == .Guide {
                    GearGuideView()
                } else if selectedTab == .Quiz {
                    GearSortingView()
                } else if selectedTab == .Profile {
                    GearSettingsView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GearTabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Home
        case Guide
        case Quiz
        case Profile
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                TabBarItem(
                    icon: "house.fill",
                    title: "Home",
                    tab: .Home,
                    selectedTab: $selectedTab
                )
                TabBarItem(
                    icon: "book.fill",
                    title: "Guide",
                    tab: .Guide,
                    selectedTab: $selectedTab
                )
                TabBarItem(
                    icon: "newspaper",
                    title: "News",
                    tab: .Quiz,
                    selectedTab: $selectedTab
                )
                TabBarItem(
                    icon: "person.circle.fill",
                    title: "Settings",
                    tab: .Profile,
                    selectedTab: $selectedTab
                )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
}

struct TabBarItem: View {
    let icon: String
    let title: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        }) {
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(selectedTab == tab ? Color(red: 52/255, green: 152/255, blue: 219/255).opacity(0.1) : Color.clear)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: selectedTab == tab ? .semibold : .medium))
                        .foregroundColor(selectedTab == tab ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 149/255, green: 165/255, blue: 166/255))
                }
                
                Text(title)
                    .font(.system(size: 11, weight: selectedTab == tab ? .semibold : .medium))
                    .foregroundColor(selectedTab == tab ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 149/255, green: 165/255, blue: 166/255))
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
} 
