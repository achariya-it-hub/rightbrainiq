'use client'

import Link from 'next/link'
import { useState, useRef, useEffect } from 'react'
import { useCart } from '@/lib/cart/provider'
import { useSupabase } from '@/lib/supabase/provider'

const categories = [
  { name: 'Smart Start Cards', slug: 'smart-start-cards', desc: 'Foundation learning cards' },
  { name: 'Connect Cards', slug: 'connect-cards', desc: 'Associative learning cards' },
  { name: 'Geo Cards', slug: 'geo-cards', desc: 'Explore places around the world' },
  { name: 'Mini Globe Cards', slug: 'mini-globe-cards', desc: 'Global awareness' },
  { name: 'Jumbo Cards', slug: 'jumbo-pack', desc: 'Large format flash cards' },
  { name: 'High Contrast', slug: 'high-contrast', desc: 'Infant visual stimulation' },
]

export default function Header() {
  const { itemCount, items, total, removeItem } = useCart()
  const { products } = useSupabase()
  const [searchOpen, setSearchOpen] = useState(false)
  const [cartOpen, setCartOpen] = useState(false)
  const [menuOpen, setMenuOpen] = useState(false)
  const [searchQuery, setSearchQuery] = useState('')
  const cartRef = useRef<HTMLDivElement>(null)
  const searchRef = useRef<HTMLDivElement>(null)

  const searchResults = searchQuery.trim()
    ? products.filter(p => p.name.toLowerCase().includes(searchQuery.toLowerCase())).slice(0, 6)
    : []

  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (cartRef.current && !cartRef.current.contains(e.target as Node)) setCartOpen(false)
      if (searchRef.current && !searchRef.current.contains(e.target as Node)) setSearchOpen(false)
    }
    document.addEventListener('mousedown', handleClick)
    return () => document.removeEventListener('mousedown', handleClick)
  }, [])

  return (
    <header className="fixed top-0 left-0 right-0 z-50 bg-white/95 backdrop-blur-md border-b border-gray-100">
      <div className="max-w-7xl mx-auto px-4 h-20 flex items-center justify-between gap-4">
        {/* Logo */}
        <Link href="/" className="flex items-center gap-2 flex-shrink-0">
          <img src="/logo.png" alt="RightBrainIQ" className="h-14 w-auto" />
        </Link>

        {/* Desktop Nav */}
        <nav className="hidden lg:flex items-center gap-1">
          <Link href="/" className="px-4 py-2.5 text-base font-medium text-gray-700 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition">
            Home
          </Link>
          <div className="relative group">
            <Link href="/products" className="px-4 py-2.5 text-base font-medium text-gray-700 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition flex items-center gap-1">
              Shop
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="6 9 12 15 18 9"/></svg>
            </Link>
            {/* Megamenu Dropdown */}
            <div className="absolute top-full left-0 w-[600px] bg-white rounded-2xl shadow-xl border border-gray-100 p-5 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 translate-y-2 group-hover:translate-y-1">
              <div className="grid grid-cols-2 gap-3">
                {categories.map(cat => (
                  <Link key={cat.slug} href={`/products?category=${cat.slug}`}
                    className="flex items-start gap-3 p-3 rounded-xl hover:bg-blue-50 transition group/cat">
                    <div className="w-10 h-10 rounded-lg bg-gradient-to-br from-[#0C52AF]/10 to-[#3496D3]/10 flex items-center justify-center flex-shrink-0">
                      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#0C52AF" strokeWidth="2"><rect x="3" y="3" width="18" height="18" rx="2"/></svg>
                    </div>
                    <div>
                      <p className="text-sm font-semibold text-gray-800 group-hover/cat:text-[#0C52AF]">{cat.name}</p>
                      <p className="text-xs text-gray-400">{cat.desc}</p>
                    </div>
                  </Link>
                ))}
              </div>
              <Link href="/products" className="block text-center mt-3 text-sm text-[#0C52AF] font-medium hover:underline py-2">
                View All Products →
              </Link>
            </div>
          </div>
          <Link href="/lms" className="px-4 py-2.5 text-base font-medium text-gray-700 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition">
            Learn
          </Link>
          <Link href="/cart" className="px-4 py-2.5 text-base font-medium text-gray-700 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition">
            Cart
          </Link>
          <Link href="/about" className="px-4 py-2.5 text-base font-medium text-gray-700 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition">
            About
          </Link>
          <Link href="/contact" className="px-4 py-2.5 text-base font-medium text-gray-700 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition">
            Contact
          </Link>
        </nav>

        {/* Right Actions */}
        <div className="flex items-center gap-2">
          {/* Search */}
          <div ref={searchRef} className="relative">
            <button onClick={() => setSearchOpen(!searchOpen)}
              className="p-2 text-gray-500 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            </button>
            {searchOpen && (
              <div className="absolute top-full right-0 mt-2 w-80 bg-white rounded-2xl shadow-xl border border-gray-100 p-3 animate-slide-down">
                <input
                  type="text"
                  placeholder="Search products..."
                  value={searchQuery}
                  onChange={e => setSearchQuery(e.target.value)}
                  autoFocus
                  className="w-full p-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF]"
                />
                {searchResults.length > 0 && (
                  <div className="mt-2 space-y-1 max-h-64 overflow-auto">
                    {searchResults.map(p => (
                      <Link key={p.id} href={`/products/${p.id}`} onClick={() => { setSearchOpen(false); setSearchQuery('') }}
                        className="flex items-center gap-3 p-2 rounded-lg hover:bg-blue-50 transition">
                        <img src={p.image_url} alt={p.name} className="w-8 h-8 rounded object-cover" />
                        <div>
                          <p className="text-sm font-medium text-gray-800">{p.name}</p>
                          <p className="text-xs text-gray-400">₹{p.price}</p>
                        </div>
                      </Link>
                    ))}
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Cart */}
          <div ref={cartRef} className="relative">
            <button onClick={() => setCartOpen(!cartOpen)}
              className="p-2 text-gray-500 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition relative">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
              </svg>
              {itemCount > 0 && (
                <span className="absolute -top-1 -right-1 bg-gradient-to-br from-[#EC2E4F] to-[#d42a4a] text-white text-[10px] rounded-full w-5 h-5 flex items-center justify-center font-bold shadow-md">
                  {itemCount}
                </span>
              )}
            </button>
            {cartOpen && (
              <div className="absolute top-full right-0 mt-2 w-80 bg-white rounded-2xl shadow-xl border border-gray-100 animate-slide-down max-h-96 flex flex-col">
                <div className="p-3 border-b border-gray-100">
                  <p className="text-sm font-semibold">Cart ({itemCount})</p>
                </div>
                <div className="flex-1 overflow-auto p-2">
                  {items.length === 0 ? (
                    <p className="text-sm text-gray-400 text-center py-8">Your cart is empty</p>
                  ) : (
                    <div className="space-y-2">
                      {items.slice(0, 4).map(item => (
                        <div key={item.product.id} className="flex items-center gap-3 p-2 rounded-lg hover:bg-gray-50">
                          <img src={item.product.image_url} alt={item.product.name} className="w-10 h-10 rounded-lg object-cover bg-gray-50" />
                          <div className="flex-1 min-w-0">
                            <p className="text-sm font-medium text-gray-800 truncate">{item.product.name}</p>
                            <p className="text-xs text-gray-400">₹{item.product.price} × {item.quantity}</p>
                          </div>
                          <button onClick={() => removeItem(item.product.id)} className="text-gray-300 hover:text-red-500">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                          </button>
                        </div>
                      ))}
                      {items.length > 4 && <p className="text-xs text-center text-gray-400 py-1">+{items.length - 4} more items</p>}
                    </div>
                  )}
                </div>
                {items.length > 0 && (
                  <div className="p-3 border-t border-gray-100">
                    <div className="flex justify-between text-sm font-semibold mb-3">
                      <span>Total</span>
                      <span className="text-[#0C52AF]">₹{total}</span>
                    </div>
                    <Link href="/cart" onClick={() => setCartOpen(false)}
                      className="block w-full text-center py-2.5 rounded-xl font-semibold text-sm bg-gradient-to-r from-[#0C52AF] to-[#0A2061] text-white shadow-md hover:shadow-lg transition">
                      View Cart
                    </Link>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Mobile Menu Toggle */}
          <button onClick={() => setMenuOpen(!menuOpen)} className="lg:hidden p-2 text-gray-500 rounded-lg hover:bg-blue-50">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              {menuOpen ? <><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></> : <><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></>}
            </svg>
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {menuOpen && (
        <div className="lg:hidden bg-white border-t border-gray-100 px-4 py-4 animate-slide-down">
          <div className="space-y-1">
            <Link href="/" onClick={() => setMenuOpen(false)} className="block px-3 py-2.5 text-base font-medium text-gray-700 rounded-lg hover:bg-blue-50">Home</Link>
            <Link href="/products" onClick={() => setMenuOpen(false)} className="block px-3 py-2.5 text-base font-medium text-gray-700 rounded-lg hover:bg-blue-50">Shop All</Link>
            {categories.map(cat => (
              <Link key={cat.slug} href={`/products?category=${cat.slug}`} onClick={() => setMenuOpen(false)}
                className="block px-3 py-2 pl-8 text-sm text-gray-600 rounded-lg hover:bg-blue-50">{cat.name}</Link>
            ))}
            <Link href="/lms" onClick={() => setMenuOpen(false)} className="block px-3 py-2.5 text-base font-medium text-gray-700 rounded-lg hover:bg-blue-50">Learn</Link>
            <hr className="my-2 border-gray-100" />
            <Link href="/about" onClick={() => setMenuOpen(false)} className="block px-3 py-2.5 text-base font-medium text-gray-700 rounded-lg hover:bg-blue-50">About Us</Link>
            <Link href="/contact" onClick={() => setMenuOpen(false)} className="block px-3 py-2.5 text-base font-medium text-gray-700 rounded-lg hover:bg-blue-50">Contact Us</Link>
          </div>
        </div>
      )}
    </header>
  )
}
