import SwiftUI

struct GearGuideView: View {
    @StateObject var gearGuideModel = GearGuideViewModel()
    @State private var isSharePresented = false
    @State private var selectedGallery: Gallery? = nil  

    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {
                        headerSection
                        galleryList
                        
                        Color.clear.frame(height: 100)
                    }
                    .padding(.top, 20)
                }
                .sheet(isPresented: $isSharePresented) {
                    ShareSheet(items: [gearGuideModel.pickedGallery.text])
                }
                .onAppear {
                    UserDefaultsManager().markAchievement2Done()
                }
                .fullScreenCover(item: $selectedGallery) { gallery in
                    GalleryDetailView(gallery: gallery)
                }
            }
            .navigationBarHidden(true)
        }
    }
}


private extension GearGuideView {
    
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
    
    var headerSection: some View {
        VStack(spacing: 8) {
            Text("Care Guide")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
            
            Text("Learn how to properly care for your equipment")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
    }
    
    var galleryList: some View {
        VStack(spacing: 20) {
            ForEach(Array(gearGuideModel.arrayOfGallery.enumerated()), id: \.element.id) { index, item in
                Button(action: {
                    selectedGallery = item
                }) {
                    galleryItemView(index: index, item: item)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 20)
    }
    
    func galleryItemView(index: Int, item: Gallery) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color(red: 52/255, green: 152/255, blue: 219/255).opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: gearGuideModel.arrayOfGallery[index].image)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(red: 52/255, green: 152/255, blue: 219/255))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(gearGuideModel.arrayOfGallery[index].title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                    
                    Text(gearGuideModel.arrayOfGallery[index].text)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
            }
            
            HStack(spacing: 20) {
                Button(action: {
                    gearGuideModel.toggleDone(for: index)
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: item.isDone ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(item.isDone ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 149/255, green: 165/255, blue: 166/255))
                        
                        Text("Save")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(item.isDone ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 149/255, green: 165/255, blue: 166/255))
                    }
                }
                
                Button(action: {
                    gearGuideModel.pickedGallery = gearGuideModel.arrayOfGallery[index]
                    isSharePresented = true
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                        
                        Text("Share")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                    }
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    GearGuideView()
}

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


struct GalleryDetailView: View {
    let gallery: Gallery
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            backgroundColor

            VStack(spacing: 20) {
                headerSection
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(gallery.detailedText)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                            .lineSpacing(6)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    private var backgroundColor: some View {
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
    
    private var headerSection: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 44, height: 44)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                }
            }
            .padding(.leading, 16)
            
            Spacer()
            
            Text(gallery.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                .multilineTextAlignment(.center)
                .padding(.trailing, 56)
            
            Spacer()
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
} 
