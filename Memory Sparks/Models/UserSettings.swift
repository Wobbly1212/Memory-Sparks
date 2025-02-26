//
//  UserSettings.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//


import Foundation

/// Manages user-specific settings and data.
class UserSettings {
    static let shared = UserSettings()

    private let usedPromptsKey = "usedPrompts"

    /// Tracks the IDs of prompts the user has already seen.
    var usedPrompts: Set<Int> {
        get {
            let savedIDs = UserDefaults.standard.array(forKey: usedPromptsKey) as? [Int] ?? []
            return Set(savedIDs)
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: usedPromptsKey)
        }
    }

    /// Adds a prompt ID to the used prompts list.
    func markPromptAsUsed(_ id: Int) {
        var updatedPrompts = usedPrompts
        updatedPrompts.insert(id)
        usedPrompts = updatedPrompts
    }

    /// Clears all stored user data.
    func reset() {
        UserDefaults.standard.removeObject(forKey: usedPromptsKey)
    }
}



