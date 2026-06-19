import Foundation

/// Stub for the iMessage scanner. The real implementation will read
/// ~/Library/Messages/chat.db (requires Full Disk Access), filter messages
/// in the source's lookback window, run AI summarization, and write the
/// results to `pending_items` via `SupabaseService`.
actor ScannerService {
    private var inFlight = false

    func scanOnce() async {
        guard !inFlight else { return }
        inFlight = true
        defer { inFlight = false }
        // TODO: implement
    }
}
