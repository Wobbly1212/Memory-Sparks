import Foundation

/// ViewModel to manage the history of saved writings.
class HistoryViewModel: ObservableObject {
    @Published var writings: [Writing] = []   // List of saved writings
    @Published var selectedWriting: Writing?  // Currently selected writing

    static let shared = HistoryViewModel()    // Singleton instance for shared access

    private init() {
        loadWritings()
    }

    /// Adds a new writing to the history and saves it persistently.
    func addWriting(_ writing: Writing) {
        writings.append(writing)
        saveWritings()
    }

    /// Deletes a writing from the history and updates persistence.
    func deleteWriting(_ writing: Writing) {
        writings.removeAll { $0.id == writing.id }
        saveWritings()
    }

    /// Selects a specific writing.
    func selectWriting(_ writing: Writing) {
        selectedWriting = writing
    }

    /// Updates an existing writing and saves changes.
    func updateWriting(_ updatedWriting: Writing) {
        if let index = writings.firstIndex(where: { $0.id == updatedWriting.id }) {
            writings[index] = updatedWriting
            saveWritings()
        }
    }

    /// Saves writings to persistent storage.
    private func saveWritings() {
        do {
            let data = try JSONEncoder().encode(writings)
            UserDefaults.standard.set(data, forKey: "writings")
        } catch {
            print("Failed to encode writings: \(error.localizedDescription)")
        }
    }

    /// Loads writings from persistent storage or uses predefined ones.
    private func loadWritings() {
        if let data = UserDefaults.standard.data(forKey: "writings") {
            do {
                let savedWritings = try JSONDecoder().decode([Writing].self, from: data)
                self.writings = savedWritings
            } catch {
                print("Failed to decode writings: \(error.localizedDescription)")
            }
        } else {
            print("No saved writings found. Loading predefined writings...")
            loadPredefinedWritings()
        }
    }
    
    /// Loads predefined writings into the history.
    private func loadPredefinedWritings() {
        let predefinedWritings = [
            Writing(id: UUID(), prompt: "The train ticket you found had today’s date.", content: "I held the ticket tightly, unsure of where it would take me.", date: Date()),
            Writing(id: UUID(), prompt: "The painting had an extra figure in the background.", content: "I swore it wasn’t there yesterday, but now it felt as if the figure was staring at me.", date: Date()),
            Writing(id: UUID(), prompt: "The lights flickered, spelling out a message.", content: "I couldn’t decipher it at first, but then I realized it was trying to say 'RUN.'", date: Date())
        ]
        self.writings = predefinedWritings
        saveWritings() // Save predefined data to persistence
    }
}
