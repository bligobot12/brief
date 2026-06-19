import Foundation
import Supabase

@MainActor
final class SupabaseService {
    let client: SupabaseClient

    init() {
        self.client = SupabaseClient(
            supabaseURL: Config.supabaseURL,
            supabaseKey: Config.supabaseAnonKey
        )
    }

    // MARK: - Auth

    func signInWithMagicLink(email: String) async throws {
        try await client.auth.signInWithOTP(email: email)
    }

    func signOut() async throws {
        try await client.auth.signOut()
    }

    // MARK: - Pending items

    func insertPendingItems(_ items: [PendingItemInsert]) async throws {
        try await client
            .from("pending_items")
            .insert(items)
            .execute()
    }

    func recentPendingItems(limit: Int = 50) async throws -> [PendingItem] {
        try await client
            .from("pending_items")
            .select()
            .order("created_at", ascending: false)
            .limit(limit)
            .execute()
            .value
    }

    // MARK: - Sources

    func sources() async throws -> [SourceRow] {
        try await client
            .from("sources")
            .select()
            .execute()
            .value
    }

    func upsertSource(_ source: SourceUpsert) async throws {
        try await client
            .from("sources")
            .upsert(source, onConflict: "user_id,source_type")
            .execute()
    }

    // MARK: - Scan logs

    func insertScanLog(_ log: ScanLogInsert) async throws {
        try await client
            .from("scan_logs")
            .insert(log)
            .execute()
    }
}
