import SwiftUI

struct UserProfile: Codable {
    var gender: String = ""
    var height: String = ""
    var weight: String = ""
    var bodyType: String = ""
}

class SurveyViewModel: ObservableObject {
    @Published var gender: String = ""
    @Published var height: Int? = nil
    @Published var weight: Int? = nil
    @Published var bodyType: String = ""

    @Published var isCompleted: Bool = false

    private let userDefaultsKey = "didCompleteSurvey3"
    private let profileKey = "userProfile3"

    init() {
        isCompleted = UserDefaults.standard.bool(forKey: userDefaultsKey)
    }

    func save() {
        let profile = UserProfile(
            gender: gender,
            height: height != nil ? "\(height!)" : "",
            weight: weight != nil ? "\(weight!)" : "",
            bodyType: bodyType
        )
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: profileKey)
        }
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
        isCompleted = true
    }

    func skip() {
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
        isCompleted = true
    }
}

struct SurveyView: View {
    @ObservedObject var vm: SurveyViewModel

    let genders = ["Male", "Female", "Other"]
    let bodyTypes = ["Ectomorph", "Mesomorph", "Endomorph"]

    let heights = Array(130...230)  // рост 130–230 см
    let weights = Array(40...150)   // вес 40–150 кг

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 41/255, green: 128/255, blue: 185/255)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    VStack {
                        Text("Tell us about yourself")
                            .PoppinsBold(size: 24)    // цвет белый
                            .padding(.top)
                        
                        Text("to make training plan specially for you")
                            .Poppins(size: 14)
                    }
                    
                    Picker("Gender", selection: $vm.gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                                .foregroundColor(.white)   // белый цвет текста в Picker
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.top)

                    // Рост
                    Picker("Height (cm)", selection: Binding(
                        get: { vm.height ?? heights.first! },
                        set: { vm.height = $0 }
                    )) {
                        ForEach(heights, id: \.self) { h in
                            Text("\(h) cm")
                                .foregroundColor(.white)
                                .tag(h)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 100)
                    .clipped()
                    .padding(.horizontal)

                    // Вес
                    Picker("Weight (kg)", selection: Binding(
                        get: { vm.weight ?? weights.first! },
                        set: { vm.weight = $0 }
                    )) {
                        ForEach(weights, id: \.self) { w in
                            Text("\(w) kg")
                                .foregroundColor(.white)
                                .tag(w)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 100)
                    .clipped()
                    .padding(.horizontal)

                    Picker("Body Type", selection: $vm.bodyType) {
                        ForEach(bodyTypes, id: \.self) { type in
                            Text(type)
                                .foregroundColor(.white)
                                .tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    Spacer()

                    HStack(spacing: 20) {
                        Button("Skip") {
                            vm.skip()
                        }
                        .foregroundColor(.gray)

                        Button("Continue") {
                            vm.save()
                        }
                        .foregroundColor(
                            (vm.gender.isEmpty || vm.height == nil || vm.weight == nil || vm.bodyType.isEmpty) ? .gray : Color(red: 52/255, green: 152/255, blue: 219/255)
                        )
                        .disabled(vm.gender.isEmpty || vm.height == nil || vm.weight == nil || vm.bodyType.isEmpty)
                    }
                    .padding()
                    .padding(.bottom, 80)
                }
            }
        }
    }
}

struct CustomSegmentedControl: View {
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selection = option
                }) {
                    Text(option)
                        .fontWeight(selection == option ? .bold : .regular)
                        .foregroundColor(selection == option ? .white : .gray)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(selection == option ? Color.blue : Color.clear)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal)
        .background(Color(red: 44/255, green: 62/255, blue: 80/255))
        .cornerRadius(10)
    }
} 