import Foundation

enum Config {
    /// Brief Supabase project URL.
    static let supabaseURL = URL(string: "https://fonrultqvptxulpuldzj.supabase.co")!

    /// Public anon key for the Brief Supabase project.
    ///
    /// Find at Supabase dashboard → Project Settings → API → "anon" "public" key.
    /// Safe to commit — the anon key is designed for client embedding and is
    /// gated by Row-Level Security policies on every table.
    static let supabaseAnonKey: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZvbnJ1bHRxdnB0eHVscHVsZHpqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE4OTI0NTksImV4cCI6MjA5NzQ2ODQ1OX0.77VLt-EFpRQvi1D81OP861pETAwdzOGrotCy8DMEBSA"
}
