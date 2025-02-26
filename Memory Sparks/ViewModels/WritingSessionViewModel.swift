//
//  WritingSessionViewModel.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// ViewModel to manage the writing session and related operations.
class WritingSessionViewModel: ObservableObject {
    @Published var writingText: String = ""  // User's current writing content
    @Published var prompt: Prompt?          // The current prompt for the session
    private let promptViewModel = PromptViewModel()  // Internal instance of PromptViewModel

    init() {
        // Initialize the prompt with the current prompt from PromptViewModel
        self.prompt = promptViewModel.currentPrompt
    }

    /// Fetches a new random prompt for the session.
    func randomizePrompt() {
        promptViewModel.selectRandomPrompt()
        self.prompt = promptViewModel.currentPrompt
    }

    /// Saves the user's writing to the history.
    func saveWriting() {
        guard let prompt = prompt, !writingText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let newWriting = Writing(
            id: UUID(),  // Generate a unique identifier
            prompt: prompt.text,  // Use the current prompt's text
            content: writingText, // Use the user-provided writing content
            date: Date()          // Use the current date
        )
        HistoryViewModel.shared.addWriting(newWriting)
        writingText = ""  // Clear the text after saving
    }

    /// Clears the current writing session.
    func clearSession() {
        writingText = ""
        randomizePrompt() // Fetch a new prompt after clearing
    }
}
