class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Cashfree Payment Gateway
  static const String cashfreeAppId = 'YOUR_CASHFREE_APP_ID';
  static const String cashfreeEnv = 'sandbox'; // 'sandbox' or 'production'

  // API base URL (Next.js server for order creation)
  // In production, set this to your deployed URL, e.g. 'https://rightbrainiq.com'
  // Leave empty to default to 'http://localhost:3000'
  static const String apiBaseUrl = '';
}
