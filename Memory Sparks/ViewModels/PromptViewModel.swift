import Foundation

/// ViewModel to manage prompts and handle prompt-related operations.
class PromptViewModel: ObservableObject {
    @Published var prompts: [Prompt] = []       // List of loaded prompts
    @Published var currentPrompt: Prompt?       // Currently selected prompt

    init() {
        loadPrompts()
        selectRandomPrompt()
    }

    /// Loads prompts from the JSON file in the app bundle or defaults to hardcoded prompts.
    private func loadPrompts() {
        if let url = Bundle.main.url(forResource: "prompts", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                prompts = try decoder.decode([Prompt].self, from: data)
                print("✅ Prompts loaded from JSON: \(prompts.count) prompts.")
            } catch {
                print("❌ Failed to load prompts from JSON: \(error.localizedDescription)")
                useDefaultPrompts()
            }
        } else {
            print("❌ prompts.json not found in bundle. Loading default prompts.")
            useDefaultPrompts()
        }
    }

    /// Selects a random prompt from the loaded list.
    func selectRandomPrompt() {
        guard !prompts.isEmpty else {
            print("❌ No prompts available. Loading default prompts.")
            useDefaultPrompts()
            return
        }
        currentPrompt = prompts.randomElement()
        print("✅ Selected prompt: \(currentPrompt?.text ?? "None")")
    }

    /// Adds a new prompt to the list.
    func addPrompt(_ newPrompt: Prompt) {
        prompts.append(newPrompt)
    }

    /// Fallback default prompts.
    private func useDefaultPrompts() {
        prompts = [
            Prompt(id: 1, text: "The power went out for just a few minutes, but when the lights returned, the arrangement of your furniture had subtly changed."),
            Prompt(id: 2, text: "Your neighbor’s cat appeared at your door with a ribbon tied around its neck and a tiny brass key dangling from it."),
            Prompt(id: 3, text: "The daily news alert was normal until the last line, which read: 'If you’re reading this, stay inside.'"),
            Prompt(id: 4, text: "The streetlight outside your window flickered every night at the same time. Tonight, it stayed off for much longer than usual."),
            Prompt(id: 5, text: "You were sorting through your old photos when you noticed that in every group picture, there was someone standing in the background wearing the same red coat."),
            Prompt(id: 6, text: "You received a voicemail, but it was just the sound of someone breathing and the faint hum of an old song in the background."),
            Prompt(id: 7, text: "Your phone buzzed with a notification: 'Your package has been delivered.' But you hadn’t ordered anything."),
            Prompt(id: 8, text: "The corner of the park bench had initials carved into it, followed by the words: 'It begins here.'"),
            Prompt(id: 9, text: "Your friend asked you about a memory you don’t recall, but they were certain you were there."),
            Prompt(id: 10, text: "You found an old train ticket in your coat pocket with today’s date stamped on it, but you don’t remember ever buying it."),
            Prompt(id: 11, text: "Your morning alarm didn’t go off, and when you checked your phone, the time was frozen at 7:03 AM."),
            Prompt(id: 12, text: "At the café, the barista handed you a cup with a name written on it that wasn’t yours—but you felt like it should be.")
        ]
        print("✅ Loaded fallback default prompts: \(prompts.count) prompts available.")
    }
}
