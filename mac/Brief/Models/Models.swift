import Foundation

// MARK: - Read shapes (decoded from Supabase)

struct PendingItem: Codable, Identifiable, Hashable {
    let id: UUID
    let userId: UUID
    let sourceType: String
    let rawContent: String
    let aiSummary: String?
    let editedContent: String?
    let confidenceScore: Double?
    let suggestedDestination: String?
    let status: String
    let routedTo: String?
    let createdAt: Date
    let actionedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case sourceType = "source_type"
        case rawContent = "raw_content"
        case aiSummary = "ai_summary"
        case editedContent = "edited_content"
        case confidenceScore = "confidence_score"
        case suggestedDestination = "suggested_destination"
        case status
        case routedTo = "routed_to"
        case createdAt = "created_at"
        case actionedAt = "actioned_at"
    }
}

struct SourceRow: Codable, Identifiable, Hashable {
    let id: UUID
    let userId: UUID
    let sourceType: String
    let enabled: Bool
    let lastScannedAt: Date?
    let scanFrequency: String
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case sourceType = "source_type"
        case enabled
        case lastScannedAt = "last_scanned_at"
        case scanFrequency = "scan_frequency"
        case createdAt = "created_at"
    }
}

// MARK: - Write shapes (insert / upsert payloads)

struct PendingItemInsert: Encodable {
    let userId: UUID
    let sourceType: String
    let rawContent: String
    let aiSummary: String?
    let confidenceScore: Double?
    let suggestedDestination: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case sourceType = "source_type"
        case rawContent = "raw_content"
        case aiSummary = "ai_summary"
        case confidenceScore = "confidence_score"
        case suggestedDestination = "suggested_destination"
    }
}

struct SourceUpsert: Encodable {
    let userId: UUID
    let sourceType: String
    let enabled: Bool
    let scanFrequency: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case sourceType = "source_type"
        case enabled
        case scanFrequency = "scan_frequency"
    }
}

struct ScanLogInsert: Encodable {
    let userId: UUID
    let sourceType: String
    let itemsFound: Int

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case sourceType = "source_type"
        case itemsFound = "items_found"
    }
}
