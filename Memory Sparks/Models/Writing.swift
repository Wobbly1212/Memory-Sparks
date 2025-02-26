//
//  Writing.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// Represents a saved writing by the user.
struct Writing: Identifiable, Codable {
    let id: UUID                 // Unique identifier for the writing
    let prompt: String           // The prompt associated with the writing
    let content: String          // User-written content
    let date: Date               // Date the writing was created

    /// A sample writing for preview and testing purposes.
    static let sampleWriting = Writing(
        id: UUID(),
        prompt: "What would you do if you could time travel?",
        content: "I would visit ancient civilizations and learn about their culture and history.",
        date: Date()
    )
}
