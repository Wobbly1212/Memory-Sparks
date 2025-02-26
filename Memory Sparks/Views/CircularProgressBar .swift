import SwiftUI

/// A reusable circular progress bar component with a label.
struct CircularProgressBar: View {
    var progress: Double
    var label: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(.white)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(
                    style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
                )
                .foregroundColor(.yellow)
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeInOut, value: progress)

            VStack {
                Text("\(Int(progress * 100))%")
                    .font(.headline)
                    .foregroundColor(.white)

                Text(label)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CircularProgressBar(progress: 0.75, label: "Prompts Completed")
        .frame(width: 120, height: 120)
}
