//
//  WritingDetailView.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import SwiftUI

/// A detailed view to display the user's saved writing.
struct WritingDetailView: View {
    let writing: Writing

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Display Prompt
            Text(writing.prompt)
                .font(.headline)
                .foregroundColor(.blue)

            // Display User's Writing
            ScrollView {
                Text(writing.content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(8)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.1))
            )
            .shadow(radius: 5)

            // Display Creation Date
            Text("Created on \(writing.date, formatter: DateFormatter.longDate)")
                .font(.footnote)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
        .navigationTitle("Writing Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Date Formatter Extension
extension DateFormatter {
    static var longDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}

// MARK: - Preview
#Preview {
    let sampleWriting = Writing(
        id: UUID(),
        prompt: "What inspires you to be creative?",
        content: "Nature inspires me the most, especially the sound of rain and the beauty of sunsets.",
        date: Date()
    )
    return WritingDetailView(writing: sampleWriting)
}
