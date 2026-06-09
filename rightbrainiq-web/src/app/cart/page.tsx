'use client'

import Link from 'next/link'
import { useCart } from '@/lib/cart/provider'
import { useToast } from '@/components/toast'
import { useState } from 'react'

const colorMap: Record<string, string> = {
  red: '#EC2E4F', orange: '#FC641E', yellow: '#FCA10C', green: '#49933F',
  teal: '#0C52AF', blue: '#0C52AF', purple: '#A52883', pink: '#E91E90', indigo: '#0829CC',
}

export default function CartPage() {
  const { items, removeItem, updateQuantity, total, itemCount } = useCart()
  const { showToast } = useToast()
  const [promo, setPromo] = useState('')
  const deliveryFee = items.length > 1 ? 49 : 0
  const grandTotal = total + deliveryFee

  if (items.length === 0) {
    return (
      <div className="max-w-3xl mx-auto px-4 py-20 text-center">
        <div className="text-7xl mb-6">🛒</div>
        <h1 className="text-3xl font-bold text-gray-800 mb-3">Your cart is empty</h1>
        <p className="text-gray-400 mb-8">Looks like you haven&apos;t added anything yet</p>
        <Link href="/products" className="btn-primary text-lg inline-block">
          Browse Products
        </Link>
      </div>
    )
  }

  return (
    <div className="max-w-5xl mx-auto px-4 py-8">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-gray-400 mb-6">
        <Link href="/" className="hover:text-[#0C52AF]">Home</Link>
        <span>/</span>
        <span className="text-gray-700 font-medium">Cart</span>
      </div>

      <h1 className="text-3xl font-bold text-[#0A2061] mb-8">Shopping Cart ({itemCount})</h1>

      <div className="grid lg:grid-cols-3 gap-8">
        {/* Items */}
        <div className="lg:col-span-2 space-y-3">
          {items.map(item => {
            const color = colorMap[item.product.color] || '#0C52AF'
            return (
              <div key={item.product.id} className="card-3d p-4 flex items-center gap-4 animate-fade-in">
                <Link href={`/products/${item.product.id}`}>
                  <img src={item.product.image_url} alt={item.product.name}
                    className="w-20 h-20 rounded-xl object-cover bg-gray-50" />
                </Link>
                <div className="flex-1 min-w-0">
                  <Link href={`/products/${item.product.id}`} className="font-semibold text-gray-800 hover:text-[#0C52AF] truncate block">
                    {item.product.name}
                  </Link>
                  <p className="text-xs text-gray-400">{item.product.card_count} cards</p>
                  <p className="font-bold mt-1" style={{ color }}>₹{item.product.price}</p>
                </div>
                <div className="flex items-center border border-gray-200 rounded-full">
                  <button onClick={() => updateQuantity(item.product.id, item.quantity - 1)}
                    className="w-9 h-9 flex items-center justify-center text-gray-500 hover:bg-gray-50 rounded-l-full transition">−</button>
                  <span className="w-10 text-center font-semibold text-sm">{item.quantity}</span>
                  <button onClick={() => updateQuantity(item.product.id, item.quantity + 1)}
                    className="w-9 h-9 flex items-center justify-center text-gray-500 hover:bg-gray-50 rounded-r-full transition">+</button>
                </div>
                <div className="text-right min-w-[70px]">
                  <p className="font-bold" style={{ color }}>₹{item.product.price * item.quantity}</p>
                </div>
                <button onClick={() => { removeItem(item.product.id); showToast('Item removed', 'info') }}
                  className="p-2 text-gray-300 hover:text-red-500 transition">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
            )
          })}
        </div>

        {/* Summary */}
        <div>
          <div className="card-3d p-6 sticky top-24">
            <h3 className="font-bold text-lg text-gray-800 mb-4">Order Summary</h3>
            <div className="space-y-3 text-sm">
              <div className="flex justify-between">
                <span className="text-gray-500">Subtotal</span>
                <span className="font-medium">₹{total}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-500">Delivery</span>
                <span className="font-medium">{deliveryFee === 0 ? 'Free' : `₹${deliveryFee}`}</span>
              </div>
              {/* Promo */}
              <div className="flex gap-2">
                <input type="text" placeholder="Promo code" value={promo} onChange={e => setPromo(e.target.value)}
                  className="flex-1 p-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:border-[#0C52AF]" />
                <button className="px-3 py-2 bg-gray-100 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-200 transition">Apply</button>
              </div>
            </div>
            <div className="border-t mt-4 pt-4">
              <div className="flex justify-between font-bold text-lg">
                <span>Total</span>
                <span className="text-[#0C52AF]">₹{grandTotal}</span>
              </div>
            </div>
            <Link href="/checkout"
              className="block w-full text-center mt-6 btn-accent py-3.5 text-base">
              Proceed to Checkout
            </Link>
          </div>
        </div>
      </div>
    </div>
  )
}
