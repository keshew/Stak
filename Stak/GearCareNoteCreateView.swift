import SwiftUI
import PhotosUI

struct GearCareNoteCreateView: View {
    @StateObject var gearCareNoteCreateModel =  GearCareNoteCreateViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var instriction = ""
    @State private var selectedIndex: Int? = nil
    @State private var selectedImages: [UIImage] = []
    @State private var isPickerPresented = false
    @State private var isShowingTimePicker = false
    @State private var reminderTime = Date()
    @State private var isShowingShareSheet = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var isFav = false
    let grid = [GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())]
    let category = ["Jersey", "Cleats", "Protection", "Accessories", "Gloves", "Bag", "Socks", "Other"]
    
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
                    
                    Text("Create Note")
                        .PoppinsBold(size: 18)
                        .padding(.trailing, 50)
                    Spacer()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        CustomTextFiled(text: $title, placeholder: "Note Title")
                        
                        Rectangle()
                            .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 52/255, green: 152/255, blue: 219/255), lineWidth: 1)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("Equipment Category")
                                                    .Poppins(size: 12, color: .white.opacity(0.7))
                                                    .padding(.leading)
                                                
                                                Spacer()
                                            }
                                            
                                            LazyVGrid(columns: grid) {
                                                ForEach(0..<8, id: \.self) { index in
                                                    Rectangle()
                                                        .fill(selectedIndex == index ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 44/255, green: 62/255, blue: 80/255))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(selectedIndex == index ? Color(red: 52/255, green: 152/255, blue: 219/255) : Color(red: 52/255, green: 152/255, blue: 219/255), lineWidth: 1)
                                                                .overlay {
                                                                    VStack {
                                                                        Image(systemName: getSystemImage(for: index))
                                                                            .resizable()
                                                                            .frame(width: 32, height: 32)
                                                                            .foregroundStyle(.white)
                                                                        
                                                                        Text(category[index])
                                                                            .Poppins(size: 10, color: .white.opacity(0.7))
                                                                    }
                                                                }
                                                        }
                                                        .frame(height: 77)
                                                        .cornerRadius(12)
                                                        .onTapGesture {
                                                            if selectedIndex == index {
                                                                selectedIndex = nil
                                                            } else {
                                                                selectedIndex = index
                                                            }
                                                        }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                            }
                            .frame(height: 224)
                            .cornerRadius(12)
                            .padding(.horizontal, 15)
                        
                        Rectangle()
                            .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 52/255, green: 152/255, blue: 219/255), lineWidth: 1)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("Care Instructions")
                                                    .Poppins(size: 12, color: .white.opacity(0.7))
                                                    .padding(.leading)
                                                
                                                Spacer()
                                            }
                                            
                                            CustomTextView(text: $instriction, placeholder: "Write your care notes here...")
                                        }
                                    }
                            }
                            .frame(height: 224)
                            .cornerRadius(12)
                            .padding(.horizontal, 15)
                        
                        Rectangle()
                            .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 52/255, green: 152/255, blue: 219/255), lineWidth: 1)
                                    .overlay {
                                        VStack(alignment: .leading) {
                                                   HStack {
                                                       Text("Attached Photos")
                                                           .font(.custom("Poppins", size: 12))
                                                           .foregroundColor(Color.white.opacity(0.7))
                                                           .padding(.leading)
                                                       
                                                       Spacer()
                                                       
                                                       Text("\(selectedImages.count)/5")
                                                           .font(.custom("Poppins", size: 12))
                                                           .foregroundColor(Color(red: 52/255, green: 152/255, blue: 219/255))
                                                           .padding(.trailing)
                                                   }
                                                   
                                                   ScrollView(.horizontal, showsIndicators: false) {
                                                       HStack(spacing: 10) {
                                                           Button {
                                                               if selectedImages.count < 5 {
                                                                   isPickerPresented = true
                                                               }
                                                           } label: {
                                                               Image(systemName: "plus.circle.fill")
                                                                   .resizable()
                                                                   .frame(width: 92, height: 80)
                                                                   .foregroundStyle(.white)
                                                                   .opacity(selectedImages.count < 5 ? 1 : 0.5)
                                                           }
                                                           .disabled(selectedImages.count >= 5)
                                                           
                                                           ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                                                               Image(uiImage: image)
                                                                   .resizable()
                                                                   .frame(width: 92, height: 80)
                                                                   .cornerRadius(8)
                                                                   .overlay(
                                                                       Button(action: {
                                                                           selectedImages.remove(at: index)
                                                                       }) {
                                                                           Image(systemName: "xmark.circle.fill")
                                                                               .foregroundColor(.white)
                                                                               .background(Color.black.opacity(0.6))
                                                                               .clipShape(Circle())
                                                                       }
                                                                       .offset(x: 40, y: -30)
                                                                   )
                                                           }
                                                       }
                                                       .padding(.horizontal)
                                                   }
                                                   .frame(height: 100)
                                               }
                                               .sheet(isPresented: $isPickerPresented) {
                                                   PhotoPicker(selectedImages: $selectedImages, maxSelection: 5)
                                               }
                                    }
                            }
                            .frame(height: 142)
                            .cornerRadius(12)
                            .padding(.horizontal, 15)
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                isShowingTimePicker = true
                            }) {
                                Rectangle()
                                    .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
                                            .overlay {
                                                VStack(spacing: 10) {
                                                    Image(systemName: "clock.fill")
                                                        .foregroundStyle(Color(red: 52/255, green: 152/255, blue: 219/255))
                                                    
                                                    Text("Set Reminder")
                                                        .Poppins(size: 12)
                                                }
                                            }
                                    }
                                    .frame(height: 86)
                                    .cornerRadius(16)
                            }
                            .sheet(isPresented: $isShowingTimePicker) {
                                VStack(spacing: 20) {
                                    Text("Select Reminder Time")
                                        .font(.headline)
                                    
                                    DatePicker("",
                                               selection: $reminderTime,
                                               displayedComponents: [.hourAndMinute])
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    
                                    Button("Done") {
                                        isShowingTimePicker = false
                                        print("Selected time: \(reminderTime)")
                                    }
                                    .padding()
                                }
                                .padding()
                            }
                            
                            Button(action: {
                                isShowingShareSheet = true
                            }) {
                                Rectangle()
                                    .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
                                            .overlay {
                                                VStack(spacing: 10) {
                                                    Image(systemName: "arrowshape.turn.up.right.fill")
                                                        .foregroundStyle(Color(red: 52/255, green: 152/255, blue: 219/255))
                                                    
                                                    Text("Share")
                                                        .Poppins(size: 12)
                                                }
                                            }
                                    }
                                    .frame(height: 86)
                                    .cornerRadius(16)
                            }
                            .sheet(isPresented: $isShowingShareSheet) {
                                         ActivityView(activityItems: ["Share link"])
                                     }
                            
                            Button(action: {
                                isFav.toggle()
                            }) {
                                Rectangle()
                                    .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(red: 52/255, green: 152/255, blue: 219/255))
                                            .overlay {
                                                VStack(spacing: 10) {
                                                    Image(systemName: "star.fill")
                                                        .foregroundStyle(Color(red: 52/255, green: 152/255, blue: 219/255))
                                                    
                                                    Text("Favourite")
                                                        .Poppins(size: 12)
                                                }
                                            }
                                    }
                                    .frame(height: 86)
                                    .cornerRadius(16)
                            }
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            saveAction()
                        }) {
                            Rectangle()
                                .fill(Color(red: 52/255, green: 152/255, blue: 219/255))
                                .overlay {
                                    Text("Save")
                                        .Poppins(size: 16)
                                }
                                .frame(height: 56)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .shadow(color: .white.opacity(0.1), radius: 10, y: 10)
                        }
                        .alert(isPresented: $showAlert) {
                                 Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                             }
                    }
                    .padding(.top)
                }
            }
        }
    }
    
    private func getSystemImage(for index: Int) -> String {
        let images = ["tshirt.fill", "shoe", "shield.fill", "bag.fill", "hand.raised.fill", "bag.fill", "sock.fill", "star.fill"]
        return images[index]
    }
    
    private func saveAction() {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Please enter a title."
            showAlert = true
            return
        }

        guard !instriction.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Please enter care instructions."
            showAlert = true
            return
        }

        guard let index = selectedIndex else {
            alertMessage = "Please select a category."
            showAlert = true
            return
        }

        let newNote = NoteModel(
            imageName: getSystemImage(for: index),
            title: title,
            category: category[index],
            instruction: instriction,
            isFav: isFav
        )

        saveNoteToUserDefaults(newNote)
        presentationMode.wrappedValue.dismiss()
    }

    private func saveNoteToUserDefaults(_ note: NoteModel) {
        let defaults = UserDefaults.standard
        var savedNotes: [NoteModel] = []

        if let data = defaults.data(forKey: "careNotes") {
            if let decoded = try? JSONDecoder().decode([NoteModel].self, from: data) {
                savedNotes = decoded
            }
        }
        
        savedNotes.append(note)
        if let encoded = try? JSONEncoder().encode(savedNotes) {
            defaults.set(encoded, forKey: "careNotes")
        }
    }
}

#Preview {
    GearCareNoteCreateView()
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    var maxSelection: Int = 5
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = maxSelection - selectedImages.count
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let uiImage = image as? UIImage {
                            DispatchQueue.main.async {
                                if self.parent.selectedImages.count < self.parent.maxSelection {
                                    self.parent.selectedImages.append(uiImage)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems,
                                 applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: Context) {}
} 
