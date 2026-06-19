import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var session: Session?
    @Published var pendingCount: Int = 0
    @Published var lastScanAt: Date?
    @Published var isScanning: Bool = false

    let supabase: SupabaseService
    let scanner: ScannerService

    init() {
        self.supabase = SupabaseService()
        self.scanner = ScannerService()
        Task { await bootstrap() }
    }

    private func bootstrap() async {
        // TODO: restore session from keychain, fetch current pending count
    }

    struct Session: Equatable {
        let userId: UUID
        let email: String
    }
}
