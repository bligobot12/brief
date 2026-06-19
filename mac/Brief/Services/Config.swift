import Foundation

enum Config {
    /// Brief Supabase project URL.
    static let supabaseURL = URL(string: "https://fonrultqvptxulpuldzj.supabase.co")!

    /// Public anon key for the Brief Supabase project.
    ///
    /// Find at Supabase dashboard → Project Settings → API → "anon" "public" key.
    /// Safe to commit — the anon key is designed for client embedding and is
    /// gated by Row-Level Security policies on every table.
    static let supabaseAnonKey: String = "REPLACE_WITH_ANON_KEY"
}
