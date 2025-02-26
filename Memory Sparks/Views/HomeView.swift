import SwiftUI

/// Revamped HomeView with alignment corrections.
struct HomeView: View {
    @State private var completedPrompts: Int = 5
    @State private var totalPrompts: Int = 10
    @State private var currentStreak: Int = 3
    @State private var motivationalQuotes = [
        "Creativity takes courage.",
        "Imagination is more important than knowledge.",
        "Start where you are. Use what you have. Do what you can.",
        "The only way to do great work is to love what you do."
    ]
    @State private var currentQuoteIndex = Int.random(in: 0..<4)
    @State private var navigateToWriting = false
    @State private var memoryCards = [
        "Prompt 1: Describe your happiest day.",
        "Prompt 2: What motivates you the most?",
        "Prompt 3: Reflect on a recent challenge.",
        "Prompt 4: Write about a favorite memory."
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Animated Galaxy Background
                AnimatedBackground()
                    .ignoresSafeArea()

                VStack(spacing: 16) { // Adjusted spacing
                    Spacer()

                    // Dynamic Welcome Section
                    Text(dynamicGreeting())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: .blue.opacity(0.6), radius: 10)
                        .padding(.top, 20)

                    // Daily Prompt Highlight
                    VStack {
                        Text("Today's Challenge")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)

                        Text(motivationalQuotes[currentQuoteIndex])
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.black.opacity(0.5))
                                    .shadow(radius: 10)
                            )
                            .padding(.horizontal, 16) // Consistent horizontal padding
                    }

                    // Memory Cards Carousel
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(memoryCards, id: \.self) { card in
                                MemoryCardView(promptText: card)
                            }
                        }
                        .padding(.horizontal, 16) // Consistent horizontal padding
                    }

                    // Streak Rewards Visualization
                    VStack(alignment: .leading, spacing: 16) {
                        StreakCardView(
                            streak: currentStreak,
                            reward: "Keep going for 7 days to unlock a new badge!"
                        )
                    }
                    .padding(.horizontal, 16) // Consistent horizontal padding

                    // Creative Insights Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Creative Insights")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)

                        InsightCardView(
                            title: "Words Written This Week",
                            value: "5,234 words"
                        )
                        InsightCardView(
                            title: "Average Session Time",
                            value: "12 minutes"
                        )
                    }
                    .padding(.horizontal, 16) // Consistent horizontal padding

                    Spacer()

                    // Start Writing Button
                    NavigationLink(destination: WritingSessionView(viewModel: WritingSessionViewModel())) {
                        ZStack {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [.yellow, .orange, .red]),
                                        center: .center,
                                        startRadius: 20,
                                        endRadius: 40
                                    )
                                )
                                .frame(width: 70, height: 70)
                                .shadow(color: .yellow.opacity(0.7), radius: 20)

                            Image(systemName: "pencil")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .shadow(color: .white.opacity(0.8), radius: 5)
                        }
                    }
                    .padding(.bottom, 30)
                }
                .padding()
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }

    /// Dynamic greeting based on the time of day.
    private func dynamicGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "Good Morning!"
        case 12..<18:
            return "Good Afternoon!"
        case 18..<24:
            return "Good Evening!"
        default:
            return "Welcome!"
        }
    }
}

/// Memory Card View for displaying past prompts.
struct MemoryCardView: View {
    let promptText: String

    var body: some View {
        VStack {
            Text(promptText)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: 200, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.6))
                .shadow(radius: 10)
        )
    }
}

/// Streak Rewards Visualization.
struct StreakCardView: View {
    let streak: Int
    let reward: String

    var body: some View {
        HStack {
            Text("🔥 \(streak)-Day Streak!")
                .font(.headline)
                .foregroundColor(.yellow)
            Spacer()
            Text(reward)
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.purple.opacity(0.8))
                .shadow(radius: 10)
        )
    }
}

/// Creative Insights Card View.
struct InsightCardView: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.headline)
                .foregroundColor(.yellow)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.4))
                .shadow(radius: 10)
        )
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
