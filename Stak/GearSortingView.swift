import SwiftUI

struct GearSortingView: View {
    @StateObject var gearSortingModel = GearSortingViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 245/255, green: 247/255, blue: 250/255),
                    Color(red: 235/255, green: 238/255, blue: 242/255)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Sports News")
                        .PoppinsBold(size: 18, color: Color(red: 44/255, green: 62/255, blue: 80/255))
                }
                .padding(.top, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(gearSortingModel.news) { article in
                            Rectangle()
                                .fill(Color.white)
                                .overlay {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 15) {
                                            Text(article.title)
                                                .Poppins(size: 16, color: .black.opacity(0.75))
                                            
                                            HStack {
                                                Link(destination: URL(string: article.link)!) {
                                                    Text("Read more")
                                                        .Poppins(size: 14, color: Color.blue.opacity(0.7))
                                                }
                                                
                                                Spacer()
                                                
                                                Text(formattedDate(from: article.pubDate))
                                                    .Poppins(size: 14, color: .black.opacity(0.3))
                                            }
                                        }
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                    }
                                }
                                .frame(height: 120)
                                .cornerRadius(24)
                                .shadow(radius: 4)
                        }
                    }
                    .padding()
                }
                
                Color.clear.frame(height: 100)
            }
        }
        .onAppear {
            gearSortingModel.fetchSportsNews()
        }
    }
    
    func formattedDate(from pubDateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = inputFormatter.date(from: pubDateString) {
            return outputFormatter.string(from: date)
        } else {
            return pubDateString
        }
    }
    
}

#Preview {
    GearSortingView()
}
