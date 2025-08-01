import SwiftUI

struct GearCareNoteView: View {
    @StateObject var gearCareNoteModel =  GearCareNoteViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var isAdd = false
    
    var body: some View {
        ZStack {
            Color(red: 41/255, green: 128/255, blue: 185/255)
                .ignoresSafeArea()
            
//            ImageEmitterView(imageName: "imim")
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Circle()
                            .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18, weight: .semibold))
                            }
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("Care Notes")
                        .PoppinsBold(size: 18)
                        .padding(.trailing, 50)
                    Spacer()
                }
                
                HStack(spacing: 20) {
                    Rectangle()
                        .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
                                .overlay {
                                    VStack {
                                        Text("\(gearCareNoteModel.totalNotesCount)")
                                            .PoppinsBold(size: 24, color: Color(red: 52/255, green: 152/255, blue: 219/255))
                                        
                                        Text("Total Notes")
                                            .Poppins(size: 12)
                                    }
                                }
                        }
                        .frame(height: 74)
                        .cornerRadius(16)
                    
                    Rectangle()
                        .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
                                .overlay {
                                    VStack {
                                        Text("\(gearCareNoteModel.notesThisWeekCount)")
                                            .PoppinsBold(size: 24, color: Color(red: 52/255, green: 152/255, blue: 219/255))
                                        
                                        Text("This week")
                                            .Poppins(size: 12)
                                    }
                                }
                        }
                        .frame(height: 74)
                        .cornerRadius(16)
                    
                    Rectangle()
                        .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
                                .overlay {
                                    VStack {
                                        Text("\(gearCareNoteModel.favoritesCount)")
                                            .PoppinsBold(size: 24, color: Color(red: 52/255, green: 152/255, blue: 219/255))
                                        
                                        Text("Favorites")
                                            .Poppins(size: 12)
                                    }
                                }
                        }
                        .frame(height: 74)
                        .cornerRadius(16)
                }
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(gearCareNoteModel.notes) { note in
                            Rectangle()
                                .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
                                        .overlay {
                                            VStack(alignment: .leading, spacing: 15) {
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 52/255, green: 152/255, blue: 219/255))
                                                        .overlay {
                                                            Image(systemName: note.imageName)
                                                                .resizable()
                                                                .frame(width: 24, height: 24)
                                                                .foregroundStyle(.white)
                                                        }
                                                        .frame(width: 40, height: 40)
                                                        .cornerRadius(12)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(note.title)
                                                            .PoppinsBold(size: 14)
                                                        Text(note.category)
                                                            .Poppins(size: 12, color: .white.opacity(0.75))
                                                    }
                                                    Spacer()
                                                    
                                                    Button(action: {
                                                        gearCareNoteModel.toggleFavourite(note: note)
                                                    }) {
                                                        Image(systemName: note.isFav ? "star.fill" : "star")
                                                            .foregroundColor(note.isFav ? .yellow : .gray)
                                                    }
                                                }
                                                
                                                HStack {
                                                    Text(note.instruction)
                                                        .Poppins(size: 12)
                                                        .lineLimit(3)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                }
                                .frame(height: 114)
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
            
            Button(action: {
                isAdd = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 72, height: 56)
                    .foregroundStyle(.white)
            }
            .position(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 1.2)
        }
        .fullScreenCover(isPresented: $isAdd) {
            GearCareNoteCreateView()
        }
    }
}

#Preview {
    GearCareNoteView()
} 
