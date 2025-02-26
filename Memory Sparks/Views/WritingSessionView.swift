import SwiftUI

struct WritingSessionView: View {
    @ObservedObject var viewModel: WritingSessionViewModel
    @State private var isSaved = false
    @State private var isTimerActive = false
    @State private var remainingTime: Int = 0
    @State private var timerDuration: Int = 300 // Default 5 minutes
    @State private var showTimerSelector = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Static Background
            StaticBackground()
                .ignoresSafeArea()
                .accessibilityHidden(true) // Decorative background hidden for VoiceOver

            ScrollView { // Enables scrolling for the entire view
                VStack(spacing: 20) {
                    // Prompt Display
                    VStack(spacing: 10) {
                        Text("")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .accessibilityLabel("Writing Session Title")
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.2))
                                .frame(minHeight: 120, maxHeight: 150) // Dynamic height
                                .shadow(radius: 10)
                                .accessibilityHidden(true)

                            VStack {
                                Text(viewModel.prompt?.text ?? "No prompt available.")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(5) // Ensures text does not overflow
                                    .minimumScaleFactor(0.7) // Adjust text size if needed
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 16)
                                    .accessibilityLabel("Current prompt")
                                    .accessibilityValue(viewModel.prompt?.text ?? "No prompt available.")

                                Button(action: {
                                    viewModel.randomizePrompt()
                                }) {
                                    Text("New Prompt")
                                        .font(.subheadline)
                                        .padding(8)
                                        .background(Color.orange.opacity(0.9))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("New Prompt Button")
                                .accessibilityHint("Taps to load a new writing prompt.")
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Writing Area
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(radius: 10)
                            .accessibilityHidden(true)

                        TextEditor(text: $viewModel.writingText)
                            .padding()
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .lineSpacing(6)
                            .accessibilityLabel("Writing area")
                            .accessibilityHint("Double tap to edit your writing.")
                    }
                    .frame(height: 250)
                    .padding(.horizontal)

                    // Timer Display
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .trim(from: 0, to: isTimerActive ? CGFloat(remainingTime) / CGFloat(timerDuration) : 1.0)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.green, .yellow, .red]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 120, height: 120)
                                .shadow(radius: 5)
                                .onLongPressGesture(minimumDuration: 0.5) {
                                    showTimerSelector.toggle()
                                    HapticFeedbackManager.triggerHapticFeedback()
                                }
                                .accessibilityLabel("Timer Circle")
                                .accessibilityValue("\(remainingTime / 60) minutes and \(remainingTime % 60) seconds remaining")
                                .accessibilityHint("Long press to set timer duration.")

                            Text("\(timeString(from: remainingTime))")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                                .accessibilityHidden(true)
                        }

                        if showTimerSelector {
                            CircularTimerSelector(
                                showTimerSelector: $showTimerSelector,
                                selectedDuration: $timerDuration,
                                startTimerCallback: { duration in
                                    startTimer(duration: duration)
                                }
                            )
                            .accessibilityLabel("Timer selector")
                            .accessibilityHint("Set timer duration.")
                        }
                    }

                    // Buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            startTimer(duration: timerDuration)
                        }) {
                            Text("Start Timer")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .accessibilityLabel("Start Timer Button")
                        .accessibilityHint("Starts the countdown timer.")

                        Button(action: {
                            viewModel.saveWriting()
                            isSaved = true
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .accessibilityLabel("Save Writing Button")
                        .accessibilityHint("Saves your current writing session.")
                    }
                    .padding(.horizontal)

                    Spacer()

                    // Cancel Button
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .accessibilityLabel("Cancel Button")
                    .accessibilityHint("Closes the writing session.")
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle("Writing Session")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isSaved) {
            Alert(
                title: Text("Saved!"),
                message: Text("Your writing has been saved."),
                dismissButton: .default(Text("OK")) {
                    dismiss()
                }
            )
        }
        .onAppear {
            viewModel.loadInitialPromptIfNeeded()
        }
    }

    // MARK: - Helper Methods
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startTimer(duration: Int) {
        remainingTime = duration
        isTimerActive = true

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                isTimerActive = false
                timer.invalidate()
            }
        }
    }
}

// MARK: - Static Background
struct StaticBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.blue.opacity(0.9), .purple.opacity(0.8)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.3))
                    .frame(width: 300, height: 300)
                    .blur(radius: 50)
                    .offset(x: -150, y: -200)

                Circle()
                    .fill(Color.pink.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .blur(radius: 40)
                    .offset(x: 150, y: 200)

                Circle()
                    .fill(Color.yellow.opacity(0.2))
                    .frame(width: 250, height: 250)
                    .blur(radius: 60)
                    .offset(x: 0, y: 0)
            }
        )
    }
}

// MARK: - Haptic Feedback
struct HapticFeedbackManager {
    static func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - WritingSessionViewModel Extension
extension WritingSessionViewModel {
    func loadInitialPromptIfNeeded() {
        if prompt == nil {
            randomizePrompt()
        }
    }
}
