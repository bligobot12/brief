import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            AccountSettingsView()
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
            SourcesSettingsView()
                .tabItem { Label("Sources", systemImage: "tray.and.arrow.down") }
        }
        .padding(20)
        .frame(width: 460, height: 320)
    }
}

private struct AccountSettingsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var email: String = ""
    @State private var statusMessage: String?

    var body: some View {
        Form {
            if let session = appState.session {
                LabeledContent("Signed in as", value: session.email)
                Button("Sign out") {
                    Task {
                        do {
                            try await appState.supabase.signOut()
                            appState.session = nil
                        } catch {
                            statusMessage = "Sign out failed: \(error.localizedDescription)"
                        }
                    }
                }
            } else {
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                Button("Send magic link") {
                    Task {
                        do {
                            try await appState.supabase.signInWithMagicLink(email: email)
                            statusMessage = "Check your inbox for a sign-in link."
                        } catch {
                            statusMessage = "Failed: \(error.localizedDescription)"
                        }
                    }
                }
                .disabled(email.isEmpty)
            }

            if let msg = statusMessage {
                Text(msg)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct SourcesSettingsView: View {
    var body: some View {
        Form {
            LabeledContent("iMessage", value: "Not yet configured")
            Text("Email sources (Gmail, Apple Mail) will be added in a later phase.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
