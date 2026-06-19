import SwiftUI

struct MenuBarContentView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.openSettings) private var openSettings

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Brief")
                    .font(.headline)
                Spacer()
            }

            Divider()

            if let session = appState.session {
                Text("Signed in as \(session.email)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text("Not signed in")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text("Pending: \(appState.pendingCount)")
                .font(.callout)

            if let last = appState.lastScanAt {
                Text("Last scan \(last.formatted(.relative(presentation: .numeric)))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Divider()

            Button {
                Task { await appState.scanner.scanOnce() }
            } label: {
                if appState.isScanning {
                    Label("Scanning…", systemImage: "arrow.triangle.2.circlepath")
                } else {
                    Label("Scan now", systemImage: "arrow.clockwise")
                }
            }
            .buttonStyle(.plain)
            .disabled(appState.isScanning)

            Button {
                openSettings()
            } label: {
                Label("Settings…", systemImage: "gearshape")
            }
            .buttonStyle(.plain)

            Divider()

            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Label("Quit Brief", systemImage: "power")
            }
            .buttonStyle(.plain)
            .keyboardShortcut("q")
        }
        .padding(12)
        .frame(width: 240)
    }
}
