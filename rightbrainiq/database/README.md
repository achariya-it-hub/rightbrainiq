# RightBrainIQ Database

This directory contains the Supabase (PostgreSQL) database setup for the RightBrainIQ e-commerce + LMS platform.

## Setup Instructions

### 1. Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign up / sign in
2. Click **New project**
3. Enter project name: `rightbrainiq`
4. Set a secure database password (save it)
5. Choose a region close to you
6. Click **Create new project** (takes ~1-2 minutes)

### 2. Run the SQL Files

In the Supabase Dashboard, go to **SQL Editor**:

1. **First**, open and run `schema.sql` — this creates all tables with Row Level Security
2. **Second**, open and run `seed.sql` — this inserts all 77 products and 6 categories
3. **Third**, open and run `functions.sql` — this creates the `place_order` function

### 3. Get Your API Credentials

In the Supabase Dashboard, go to **Project Settings → API**:

- **Project URL**: Copy the URL (looks like `https://xxxxx.supabase.co`)
- **Anon Key**: Copy the public anon key

### 4. Configure the Flutter App

Open `lib/services/supabase_config.dart` in the Flutter project and update:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
}
```

### 5. Configure the Next.js Web App

1. Copy `.env.local.example` to `.env.local` in the web project
2. Fill in:

```
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

3. Run `npm install` then `npm run dev`

## Database Schema

| Table | Purpose |
|-------|---------|
| `categories` | Product categories (6 rows) |
| `products` | All 77 products with images, prices, colors |
| `profiles` | User profiles (synced with auth.users) |
| `orders` | Customer orders |
| `order_items` | Items within each order |
| `cart_items` | Shopping cart items per user |
| `subscriptions` | LMS course subscriptions |

## Row Level Security

All tables have RLS enabled so users can only access their own data. The `profiles` table auto-syncs with `auth.users` via triggers (the schema includes insert policies for new sign-ups).
