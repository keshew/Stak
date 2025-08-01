import SwiftUI

struct GearProgressView: View {
    @StateObject var model = GearProgressViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor

                VStack(spacing: 0) {
                    headerSection
                    
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(model.workouts) { workout in
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    WorkoutRow(workout: workout)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

private extension GearProgressView {
    
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
            
            Text("Care Routines")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                .padding(.trailing, 60)
            
            Spacer()
        }
        .padding(.top, 10)
    }
}

import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    @Environment(\.presentationMode) var presentationMode
    @State private var showTimer = false
    var body: some View {
        ZStack {
            backgroundColor

            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Large image
                        ZStack {
                            Circle()
                                .fill(workoutColor.opacity(0.1))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: workout.imageName)
                                .font(.system(size: 50, weight: .medium))
                                .foregroundColor(workoutColor)
                        }
                        .padding(.top, 20)
                        
                        // Statistics
                        HStack(spacing: 30) {
                            statItem(title: "Duration", value: workout.duration, icon: "clock.fill")
                            statItem(title: "Difficulty", value: workout.difficulty, icon: "speedometer")
                            statItem(title: "Rating", value: String(format: "%.1f", workout.rating), icon: "star.fill")
                        }
                        .padding(.horizontal, 20)
                        
                        // Description
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Description")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                            
                            Text(workout.description)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 20)
                        
                        // Steps count
                        HStack {
                            Text("Steps:")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                            Text("\(workout.exercisesCount)")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(workoutColor)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        // Start button
                        Button(action: {
                            showTimer = true
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Text("Start Care Routine")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(workoutColor)
                                    .shadow(color: workoutColor.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 30)
                        .background(
                            NavigationLink(destination: TrainingTimerView(workout: workout), isActive: $showTimer) {
                                  EmptyView()
                            }
                                .hidden()
                        )
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
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
    
    private var workoutColor: Color {
        switch workout.difficulty {
        case "Beginner":
            return Color(red: 46/255, green: 204/255, blue: 113/255)
        case "Intermediate":
            return Color(red: 52/255, green: 152/255, blue: 219/255)
        case "Advanced":
            return Color(red: 155/255, green: 89/255, blue: 182/255)
        default:
            return Color(red: 52/255, green: 152/255, blue: 219/255)
        }
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
            
            Text(workout.name)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
            
            Spacer()
            
            Circle()
                .fill(Color.clear)
                .frame(width: 44, height: 44)
                .padding(.trailing, 16)
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
    
    private func statItem(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(workoutColor.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(workoutColor)
            }
            
            VStack(spacing: 2) {
                Text(value)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
            }
        }
    }
}

struct StarRatingView: View {
    let rating: Double
    var maxStars = 5
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxStars, id: \.self) { num in
                if Double(num) <= rating {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color(red: 241/255, green: 196/255, blue: 15/255))
                } else if Double(num) - rating < 1 {
                    Image(systemName: "star.leadinghalf.filled")
                        .foregroundColor(Color(red: 241/255, green: 196/255, blue: 15/255))
                } else {
                    Image(systemName: "star")
                        .foregroundColor(Color(red: 236/255, green: 240/255, blue: 241/255))
                }
            }
        }
    }
}

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(workoutColor.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: workout.imageName)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(workoutColor)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(workout.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 44/255, green: 62/255, blue: 80/255))
                
                HStack(spacing: 12) {
                    Label(workout.duration, systemImage: "clock")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                    
                    Label(workout.difficulty, systemImage: "speedometer")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 149/255, green: 165/255, blue: 166/255))
                }
            }
            
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
    
    private var workoutColor: Color {
        switch workout.difficulty {
        case "Beginner":
            return Color(red: 46/255, green: 204/255, blue: 113/255)
        case "Intermediate":
            return Color(red: 52/255, green: 152/255, blue: 219/255)
        case "Advanced":
            return Color(red: 155/255, green: 89/255, blue: 182/255)
        default:
            return Color(red: 52/255, green: 152/255, blue: 219/255)
        }
    }
}

#Preview {
    GearProgressView()
} 
