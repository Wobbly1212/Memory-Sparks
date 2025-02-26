import Foundation

/// ViewModel to manage user settings and preferences.
class SettingsViewModel: ObservableObject {
    @Published var selectedFont: String {
        didSet {
            saveSettings()
        }
    }
    @Published var theme: AppTheme {
        didSet {
            saveSettings()
        }
    }
    @Published var enableNotifications: Bool {
        didSet {
            saveSettings()
        }
    }
    @Published var reminderTime: Date {
        didSet {
            saveSettings()
        }
    }

    private let defaults = UserDefaults.standard

    init() {
        // Load saved settings or set defaults
        self.selectedFont = defaults.string(forKey: "selectedFont") ?? "Noteworthy"
        self.theme = AppTheme(rawValue: defaults.string(forKey: "theme") ?? AppTheme.dynamic.rawValue) ?? .dynamic
        self.enableNotifications = defaults.bool(forKey: "enableNotifications")
        self.reminderTime = defaults.object(forKey: "reminderTime") as? Date ?? Date()
    }

    /// Saves settings to UserDefaults.
    private func saveSettings() {
        defaults.set(selectedFont, forKey: "selectedFont")
        defaults.set(theme.rawValue, forKey: "theme")
        defaults.set(enableNotifications, forKey: "enableNotifications")
        defaults.set(reminderTime, forKey: "reminderTime")
    }

    /// Resets settings to default values.
    func resetSettings() {
        selectedFont = "Noteworthy"
        theme = .dynamic
        enableNotifications = true
        reminderTime = Date()
    }
}

