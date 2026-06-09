'use client'

import { createContext, useContext, useEffect, useState } from 'react'
import { supabase, type Product, type Category } from './client'
import { staticProducts, staticCategories } from './static-data'

type SupabaseContextType = {
  products: Product[]
  categories: Category[]
  loading: boolean
  getProduct: (id: string) => Product | undefined
  getProductsByCategory: (slug: string) => Product[]
}

const SupabaseContext = createContext<SupabaseContextType | null>(null)

export function useSupabase() {
  const ctx = useContext(SupabaseContext)
  if (!ctx) throw new Error('useSupabase must be used within SupabaseProvider')
  return ctx
}

export default function SupabaseProvider({ children }: { children: React.ReactNode }) {
  const [products, setProducts] = useState<Product[]>(staticProducts)
  const [categories, setCategories] = useState<Category[]>(staticCategories)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function load() {
      try {
        const [prodRes, catRes] = await Promise.all([
          supabase.from('products').select('*').order('id'),
          supabase.from('categories').select('*').order('id'),
        ])
        if (prodRes.data && prodRes.data.length > 0) setProducts(prodRes.data)
        if (catRes.data && catRes.data.length > 0) setCategories(catRes.data)
      } catch (_) {
        // Supabase not configured — using static data
      }
      setLoading(false)
    }
    load()
  }, [])

  const getProduct = (id: string) => products.find(p => p.id === id)
  const getProductsByCategory = (slug: string) => products.filter(p => p.category_slug === slug)

  return (
    <SupabaseContext.Provider value={{ products, categories, loading, getProduct, getProductsByCategory }}>
      {children}
    </SupabaseContext.Provider>
  )
}
