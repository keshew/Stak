import SwiftUI

struct TrainingTimerView: View {
    @Environment(\.presentationMode) var presentationMode

    let workout: Workout // Нужно передать Workout при навигации в TrainingTimerView

    @State private var secondsRemaining = 15 * 60
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var completedReps = 0

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
            
            VStack(spacing: 40) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Circle()
                            .fill(Color(red: 44/255, green: 62/255, blue: 80/255))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .semibold))
                            }
                    }
                    .padding(.leading, 16)

                    Spacer()
                }
                Spacer()

                Text(timeString(from: secondsRemaining))
                    .PoppinsBold(size: 64, color: Color(red: 151/255, green: 222/255, blue: 246/255))

                // Показываем количество выполненных подходов
                Text("Steps: \(completedReps) / \(workout.exercisesCount)")
                    .Poppins(size: 17, color: Color(red: 151/255, green: 222/255, blue: 246/255))
                    .padding()

                HStack(spacing: 30) {
                    Button(action: {
                        if timerRunning {
                            pauseTimer()
                        } else {
                            startTimer()
                        }
                    }) {
                        Text(timerRunning ? "Pause" : "Start")
                            .fontWeight(.semibold)
                            .frame(width: 120, height: 50)
                            .background(Color(red: 52/255, green: 152/255, blue: 219/255))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button(action: {
                        // Добавляем один подход
                        completedReps += 1

                        if completedReps >= workout.exercisesCount {
                            // Закрываем экран по достижении максимума
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            // Сброс таймера для следующего подхода
                            stopTimer()
                        }
                    }) {
                        Text("Complete")
                            .fontWeight(.semibold)
                            .frame(width: 120, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .navigationBarBackButtonHidden(true)
    }

    func startTimer() {
        if secondsRemaining <= 0 {
            secondsRemaining = 15 * 60
        }
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard secondsRemaining > 0 else {
                stopTimer()
                return
            }
            secondsRemaining -= 1
        }
    }

    func pauseTimer() {
        timerRunning = false
        timer?.invalidate()
    }

    func stopTimer() {
        timerRunning = false
        timer?.invalidate()
        secondsRemaining = 15 * 60
    }

    func timeString(from seconds: Int) -> String {
        let min = seconds / 60
        let sec = seconds % 60
        return String(format: "%02d:%02d", min, sec)
    }
} 
