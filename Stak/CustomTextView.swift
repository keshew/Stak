import SwiftUI

struct CustomTextView: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var height: CGFloat = 158
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.clear)
                .cornerRadius(26)
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 15)
                .padding(.top, 5)
                .frame(height: height)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundStyle(.white)
                .focused($isTextFocused)
            
            if text.isEmpty && !isTextFocused {
                VStack {
                    Text(placeholder)
                        .Poppins(size: 14, color: .white.opacity(0.7))
                        .padding(.horizontal, 17)
                        .padding(.top, 10)
                        .onTapGesture {
                            isTextFocused = true
                        }
                    Spacer()
                }
            }
        }
        .frame(height: height)
    }
}

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 52/255, green: 152/255, blue: 219/255), lineWidth: 1)
                }
                .frame(height: 50)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 16)
            .frame(height: 47)
            .font(.custom("Poppins-Regular", size: 15))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Poppins(size: 16, color: Color(red: 149/255, green: 165/255, blue: 166/255))
                    .frame(height: 50)
                    .padding(.leading, 30)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
} 