'use client'

import { useParams } from 'next/navigation'
import Link from 'next/link'
import { useState } from 'react'
import { useSupabase } from '@/lib/supabase/provider'
import { useCart } from '@/lib/cart/provider'
import { useToast } from '@/components/toast'

const colorMap: Record<string, string> = {
  red: '#EC2E4F', orange: '#FC641E', yellow: '#FCA10C', green: '#49933F',
  teal: '#0C52AF', blue: '#0C52AF', purple: '#A52883', pink: '#E91E90', indigo: '#0829CC',
}

export default function ProductDetailPage() {
  const { id } = useParams<{ id: string }>()
  const { getProduct } = useSupabase()
  const { addItem } = useCart()
  const { showToast } = useToast()
  const [qty, setQty] = useState(1)
  const [showPerCard, setShowPerCard] = useState(false)
  const [zoom, setZoom] = useState(false)
  const product = getProduct(id)

  if (!product) {
    return (
      <div className="max-w-7xl mx-auto px-4 py-20 text-center">
        <div className="text-6xl mb-4">📦</div>
        <p className="text-gray-400 text-lg">Product not found</p>
        <Link href="/products" className="text-[#0C52AF] hover:underline mt-4 inline-block">← Back to shop</Link>
      </div>
    )
  }

  const color = colorMap[product.color] || '#0C52AF'
  const displayPrice = showPerCard ? product.price / product.card_count : product.price
  const unit = showPerCard ? '/ card' : ''

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-gray-400 mb-6">
        <Link href="/" className="hover:text-[#0C52AF]">Home</Link>
        <span>/</span>
        <Link href="/products" className="hover:text-[#0C52AF]">Products</Link>
        <span>/</span>
        <span className="text-gray-700">{product.name}</span>
      </div>

      <div className="grid md:grid-cols-2 gap-10">
        {/* Image */}
        <div className="space-y-3">
          <div
            className={`relative bg-gradient-to-br from-gray-50 to-gray-100 rounded-2xl overflow-hidden cursor-crosshair ${zoom ? 'scale-105' : ''} transition-transform duration-300`}
            onMouseEnter={() => setZoom(true)}
            onMouseLeave={() => setZoom(false)}
          >
            <img
              src={product.image_url}
              alt={product.name}
              className="w-full aspect-square object-cover"
              onError={(e) => { if (product.image_url2) (e.currentTarget as HTMLImageElement).src = product.image_url2 }}
            />
            {/* Category badge */}
            <span className="absolute top-4 left-4 px-3 py-1 rounded-full text-xs font-semibold bg-white/90 backdrop-blur-sm shadow-sm"
              style={{ color }}>
              {product.category_slug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase())}
            </span>
          </div>
          {product.image_url2 && (
            <div className="grid grid-cols-4 gap-2">
              {[product.image_url, product.image_url2].map((url, i) => (
                <div key={i} className="rounded-xl overflow-hidden border border-gray-100">
                  <img src={url} alt="" className="w-full aspect-square object-cover" />
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Info */}
        <div className="flex flex-col justify-center">
          <h1 className="text-3xl md:text-4xl font-bold text-[#0A2061] mb-2">{product.name}</h1>

          <div className="flex items-center gap-3 mb-4">
            <span className="text-sm text-gray-500 bg-gray-100 px-3 py-1 rounded-full">{product.card_count} cards</span>
            <span className="text-sm text-gray-500 bg-gray-100 px-3 py-1 rounded-full">{product.category_slug}</span>
          </div>

          {/* Price */}
          <div className="mb-6">
            <div className="flex items-baseline gap-3">
              <span className="text-4xl font-extrabold price-3d animate-count-up" style={{ color }}>
                ₹{Math.round(displayPrice)}
              </span>
              <span className="text-gray-400 text-sm">{unit}</span>
            </div>
            <button
              onClick={() => setShowPerCard(!showPerCard)}
              className="text-xs text-[#0C52AF] font-medium hover:underline mt-1"
            >
              {showPerCard ? 'Show total price' : 'Show price per card'}
            </button>
          </div>

          <p className="text-gray-600 mb-8 leading-relaxed">
            {product.description || `${product.name} flash cards — ${product.card_count} cards per pack. Perfect for early brain development.`}
          </p>

          {/* Quantity */}
          <div className="flex items-center gap-4 mb-6">
            <span className="text-sm font-medium text-gray-700">Quantity:</span>
            <div className="flex items-center border border-gray-200 rounded-full">
              <button onClick={() => setQty(Math.max(1, qty - 1))}
                className="w-10 h-10 flex items-center justify-center text-gray-500 hover:bg-gray-50 rounded-l-full transition">−</button>
              <span className="w-12 text-center font-semibold">{qty}</span>
              <button onClick={() => setQty(qty + 1)}
                className="w-10 h-10 flex items-center justify-center text-gray-500 hover:bg-gray-50 rounded-r-full transition">+</button>
            </div>
          </div>

          {/* Add to Cart */}
          <button
            onClick={() => {
              for (let i = 0; i < qty; i++) addItem(product)
              showToast(`${qty} × ${product.name} added to cart`)
            }}
            className="btn-primary text-lg py-4 w-full md:w-auto px-12 flex items-center justify-center gap-3"
          >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
              <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
            </svg>
            Add to Cart — ₹{Math.round(product.price * qty)}
          </button>

          {/* Features */}
          <div className="grid grid-cols-2 gap-3 mt-8">
            {[
              { icon: '🎨', text: 'Vibrant Illustrations' },
              { icon: '📏', text: 'Durable Material' },
              { icon: '🧠', text: 'Expert Designed' },
              { icon: '🎯', text: 'Age 0-8 Years' },
            ].map((f, i) => (
              <div key={i} className="flex items-center gap-2 text-sm text-gray-600">
                <span>{f.icon}</span>
                <span>{f.text}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
