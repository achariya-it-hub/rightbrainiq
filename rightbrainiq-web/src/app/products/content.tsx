'use client'

import { useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { useSupabase } from '@/lib/supabase/provider'
import ProductCard from '@/components/product-card'

export default function ProductsContent() {
  const searchParams = useSearchParams()
  const category = searchParams.get('category')
  const { products, categories, loading } = useSupabase()

  const filtered = category
    ? products.filter(p => p.category_slug === category)
    : products

  const currentCat = category ? categories.find(c => c.slug === category) : null

  if (loading) {
    return (
      <div className="animate-pulse">
        <div className="h-8 w-48 shimmer mb-4" />
        <div className="flex gap-2 mb-8">{[...Array(6)].map((_, i) => <div key={i} className="h-8 w-24 shimmer rounded-full" />)}</div>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">{[...Array(8)].map((_, i) => <div key={i} className="h-72 shimmer rounded-2xl" />)}</div>
      </div>
    )
  }

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-gray-400 mb-6">
        <Link href="/" className="hover:text-[#0C52AF]">Home</Link>
        <span>/</span>
        <span className="text-gray-700 font-medium">{currentCat ? currentCat.name : 'All Products'}</span>
      </div>

      <div className="flex flex-col md:flex-row gap-8">
        {/* Sidebar Filters */}
        <div className="md:w-56 flex-shrink-0">
          <h3 className="font-bold text-sm text-gray-800 mb-3">Categories</h3>
          <div className="space-y-1">
            <Link href="/products"
              className={`block px-3 py-2 rounded-lg text-sm transition ${
                !category ? 'bg-[#0C52AF]/10 text-[#0C52AF] font-semibold' : 'text-gray-600 hover:bg-gray-100'
              }`}>
              All Products
              <span className="text-xs text-gray-400 ml-2">({products.length})</span>
            </Link>
            {categories.map(cat => (
              <Link key={cat.slug} href={`/products?category=${cat.slug}`}
                className={`block px-3 py-2 rounded-lg text-sm transition ${
                  category === cat.slug ? 'bg-[#0C52AF]/10 text-[#0C52AF] font-semibold' : 'text-gray-600 hover:bg-gray-100'
                }`}>
                {cat.name}
                <span className="text-xs text-gray-400 ml-2">({cat.product_count})</span>
              </Link>
            ))}
          </div>
        </div>

        {/* Main Content */}
        <div className="flex-1">
          <div className="mb-6">
            <h1 className="text-3xl font-bold text-[#0A2061]">{currentCat ? currentCat.name : 'All Products'}</h1>
            <p className="text-gray-500 mt-1">{filtered.length} products</p>
          </div>

          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-3 gap-4">
            {filtered.map((p, i) => <ProductCard key={p.id} product={p} index={i} />)}
          </div>

          {filtered.length === 0 && (
            <div className="text-center py-20">
              <p className="text-gray-400 text-lg">No products found in this category</p>
              <Link href="/products" className="text-[#0C52AF] hover:underline mt-2 inline-block">View all products →</Link>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
