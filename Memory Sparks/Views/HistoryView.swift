import SwiftUI

/// HistoryView with dynamic cards and meaningful design.
struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.2), .purple.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                if viewModel.writings.isEmpty {
                    // Empty State
                    VStack {
                        Image(systemName: "tray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)

                        Text("No writings yet.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                } else {
                    // List of Writings as Dynamic Cards
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.writings) { writing in
                                HistoryCard(writing: writing)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        // Navigate to WritingDetailView
                                        viewModel.selectWriting(writing)
                                    }
                                    .contextMenu {
                                        Button("Delete") {
                                            viewModel.deleteWriting(writing)
                                        }
                                    }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

// MARK: - History Card
struct HistoryCard: View {
    let writing: Writing

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange.opacity(0.8), .pink.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 10)

            VStack(alignment: .leading, spacing: 10) {
                Text(writing.prompt)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .padding(.bottom, 5)

                Text(writing.content)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(3)

                Text("Created on \(writing.date, formatter: DateFormatter.shortDate)")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.top, 5)
            }
            .padding()
        }
        .frame(height: 150)
    }
}

// MARK: - Date Formatter
extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}


