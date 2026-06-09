'use client'

import Link from 'next/link'
import { useState } from 'react'
import { useCart } from '@/lib/cart/provider'
import { useToast } from './toast'
import type { Product } from '@/lib/supabase/client'

const colorMap: Record<string, string> = {
  red: '#EC2E4F', orange: '#FC641E', yellow: '#FCA10C', green: '#49933F',
  teal: '#0C52AF', blue: '#0C52AF', purple: '#A52883', pink: '#E91E90', indigo: '#0829CC',
}

export default function ProductCard({ product, index = 0 }: { product: Product; index?: number }) {
  const { addItem } = useCart()
  const { showToast } = useToast()
  const [imgLoaded, setImgLoaded] = useState(false)
  const color = colorMap[product.color] || '#0C52AF'

  return (
    <div className={`card-3d animate-fade-in-up stagger-${Math.min(index + 1, 6)}`}>
      <Link href={`/products/${product.id}`}>
        <div className="relative aspect-square bg-gradient-to-br from-gray-50 to-gray-100 overflow-hidden">
          {!imgLoaded && <div className="absolute inset-0 shimmer" />}
          <img
            src={product.image_url}
            alt={product.name}
            className={`w-full h-full object-cover transition-all duration-500 ${imgLoaded ? 'opacity-100' : 'opacity-0'}`}
            onLoad={() => setImgLoaded(true)}
            onError={(e) => {
              const t = e.currentTarget
              if (product.image_url2) t.src = product.image_url2
              else setImgLoaded(true)
            }}
          />
          {/* Hover overlay */}
          <div className="absolute inset-0 bg-gradient-to-t from-black/10 to-transparent opacity-0 hover:opacity-100 transition-opacity duration-300" />
        </div>
      </Link>

      {/* 3D Embossed Info Box */}
      <div className="info-box" style={{ borderColor: `${color}20` }}>
        <Link href={`/products/${product.id}`}>
          <h3 className="font-bold text-sm text-gray-800 truncate hover:text-[#0C52AF] transition-colors">{product.name}</h3>
        </Link>
        <div className="flex items-center justify-between mt-2">
          <div>
            <span className="price-3d text-base" style={{ color }}>₹{product.price}</span>
            <span className="text-[10px] text-gray-400 ml-1">/ pack</span>
          </div>
          <button
            onClick={() => { addItem(product); showToast(`${product.name} added to cart`) }}
            className="flex items-center gap-1.5 px-4 py-2 rounded-full text-xs font-bold text-white transition-all hover:shadow-lg active:scale-95"
            style={{ background: `linear-gradient(135deg, ${color} 0%, ${color}dd 100%)` }}
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
              <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
            </svg>
            Add
          </button>
        </div>
        <div className="flex items-center gap-2 mt-2">
          <span className="text-[10px] text-gray-400 bg-white/60 px-2 py-0.5 rounded-full">{product.card_count} cards</span>
        </div>
      </div>
    </div>
  )
}
