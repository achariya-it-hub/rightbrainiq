import { createBrowserClient } from '@supabase/ssr'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || ''
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''

let _supabase: ReturnType<typeof createBrowserClient> | null = null

function getClient() {
  if (!_supabase) {
    _supabase = createBrowserClient(
      supabaseUrl || 'https://placeholder.supabase.co',
      supabaseAnonKey || 'placeholder-key'
    )
  }
  return _supabase
}

export const supabase = new Proxy({} as ReturnType<typeof createBrowserClient>, {
  get(_, prop) {
    return (getClient() as any)[prop]
  },
})

export type Product = {
  id: string
  name: string
  category_slug: string
  price: number
  currency: string
  image_url: string
  image_url2: string | null
  card_count: number
  description: string
  color: string
}

export type Category = {
  id: number
  name: string
  slug: string
  product_count: number
  image_url: string
  description: string
}
