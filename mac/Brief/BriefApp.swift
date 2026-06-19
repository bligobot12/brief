import SwiftUI

@main
struct BriefApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        MenuBarExtra("Brief", systemImage: "checkmark.seal") {
            MenuBarContentView()
                .environmentObject(appState)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
                .environmentObject(appState)
        }
    }
}
