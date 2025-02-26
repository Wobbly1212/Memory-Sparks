import SwiftUI

struct CircularTimerSelector: View {
    @Binding var showTimerSelector: Bool
    @Binding var selectedDuration: Int
    var startTimerCallback: (Int) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Timer Duration")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            HStack(spacing: 20) {
                TimerOptionButton(label: "3 min", duration: 180, selectedDuration: $selectedDuration)
                TimerOptionButton(label: "5 min", duration: 300, selectedDuration: $selectedDuration)
                TimerOptionButton(label: "10 min", duration: 600, selectedDuration: $selectedDuration)
            }
            .padding()

            Button(action: {
                showTimerSelector = false
                startTimerCallback(selectedDuration)
            }) {
                Text("Start")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Button(action: {
                showTimerSelector = false
            }) {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.8))
                .shadow(radius: 10)
        )
        .padding(.horizontal, 40)
    }
}

struct TimerOptionButton: View {
    let label: String
    let duration: Int
    @Binding var selectedDuration: Int

    var body: some View {
        Button(action: {
            selectedDuration = duration
        }) {
            Text(label)
                .font(.subheadline)
                .frame(width: 80, height: 80)
                .background(
                    Circle()
                        .fill(selectedDuration == duration ? Color.blue : Color.gray.opacity(0.2))
                )
                .foregroundColor(.white)
                .overlay(
                    Circle()
                        .stroke(selectedDuration == duration ? Color.white : Color.clear, lineWidth: 3)
                )
                .shadow(radius: selectedDuration == duration ? 5 : 0)
        }
    }
}
