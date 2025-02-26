import SwiftUI

/// SettingsView with personalization options and a modern design.
struct SettingsView: View {
    @State private var selectedFont: String = "Noteworthy"
    @State private var theme: AppTheme = .dynamic
    @State private var enableNotifications: Bool = true
    @State private var writingReminderTime: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                // Font Customization Section
                Section(header: Text("Font Customization").font(.headline)) {
                    Picker("Writing Font", selection: $selectedFont) {
                        ForEach(FontOptions.allCases, id: \.self) { font in
                            Text(font.rawValue).tag(font.rawValue)
                        }
                    }
                }

                // Theme Customization Section
                Section(header: Text("Theme").font(.headline)) {
                    Picker("App Theme", selection: $theme) {
                        ForEach(AppTheme.allCases, id: \.self) { themeOption in
                            Text(themeOption.displayName).tag(themeOption)
                        }
                    }
                }

                // Notification Settings Section
                Section(header: Text("Notifications").font(.headline)) {
                    Toggle("Enable Notifications", isOn: $enableNotifications)

                    if enableNotifications {
                        DatePicker(
                            "Reminder Time",
                            selection: $writingReminderTime,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Font Options Enum
enum FontOptions: String, CaseIterable {
    case Noteworthy = "Noteworthy"
    case Helvetica = "Helvetica"
    case TimesNewRoman = "Times New Roman"
    case Courier = "Courier"
}

// MARK: - App Theme Enum
enum AppTheme: String, CaseIterable {
    case light
    case dark
    case dynamic

    var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .dynamic: return "Dynamic"
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
