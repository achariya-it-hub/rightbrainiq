'use client'

import { useState, useEffect, Suspense } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { useCart } from '@/lib/cart/provider'
import { useToast } from '@/components/toast'
import { load } from '@cashfreepayments/cashfree-js'

function CheckoutContent() {
  const { items, total, clearCart } = useCart()
  const { showToast } = useToast()
  const router = useRouter()
  const searchParams = useSearchParams()
  const [form, setForm] = useState({ address: '', city: '', pincode: '', phone: '' })
  const [payment, setPayment] = useState('COD')
  const [placing, setPlacing] = useState(false)
  const [cfReady, setCfReady] = useState(false)

  useEffect(() => {
    if (items.length === 0) {
      router.push('/cart')
    }
  }, [items, router])

  useEffect(() => {
    load({ mode: process.env.NEXT_PUBLIC_CASHFREE_ENV || 'sandbox' }).then(() => {
      setCfReady(true)
    })
  }, [])

  const orderId = searchParams.get('order_id')
  const paymentStatus = searchParams.get('payment_status')

  useEffect(() => {
    if (orderId && paymentStatus === 'SUCCESS') {
      clearCart()
      showToast('Payment successful! Order placed. 🎉')
      router.push('/products')
    } else if (orderId && paymentStatus === 'FAILED') {
      showToast('Payment failed. Please try again.', 'error')
    }
  }, [orderId, paymentStatus, clearCart, showToast, router])

  if (items.length === 0 && !orderId) return null

  const deliveryFee = items.length > 1 ? 49 : 0
  const grandTotal = total + deliveryFee

  const handlePlaceOrder = async () => {
    if (!form.address || !form.city || !form.pincode || !form.phone) {
      showToast('Please fill in all delivery details', 'error')
      return
    }
    if (payment === 'COD') {
      setPlacing(true)
      await new Promise(r => setTimeout(r, 2000))
      clearCart()
      showToast('Order placed successfully! 🎉')
      router.push('/products')
      return
    }

    if (!process.env.NEXT_PUBLIC_CASHFREE_APP_ID) {
      showToast('Cashfree not configured. Use COD for now.', 'error')
      return
    }

    setPlacing(true)
    try {
      const res = await fetch('/api/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          order_amount: grandTotal,
          customer_phone: form.phone,
          customer_name: 'Guest',
          customer_email: 'guest@example.com',
        }),
      })
      const data = await res.json()
      if (!data.success) {
        showToast(data.message || 'Failed to initiate payment', 'error')
        setPlacing(false)
        return
      }
      const cashfree = await load({ mode: process.env.NEXT_PUBLIC_CASHFREE_ENV || 'sandbox' })
      await cashfree.checkout({
        paymentSessionId: data.data.payment_session_id,
        redirectTarget: '_self',
      })
    } catch (err) {
      showToast('Payment failed. Please try again.', 'error')
      setPlacing(false)
    }
  }

  return (
    <div className="max-w-5xl mx-auto px-4 py-8">
      <div className="flex items-center gap-2 text-sm text-gray-400 mb-6">
        <Link href="/" className="hover:text-[#0C52AF]">Home</Link>
        <span>/</span>
        <Link href="/cart" className="hover:text-[#0C52AF]">Cart</Link>
        <span>/</span>
        <span className="text-gray-700 font-medium">Checkout</span>
      </div>

      <h1 className="text-3xl font-bold text-[#0A2061] mb-8">Checkout</h1>

      <div className="grid lg:grid-cols-5 gap-8">
        <div className="lg:col-span-3 space-y-8">
          <div className="card-3d p-6">
            <h2 className="font-bold text-lg text-gray-800 mb-4 flex items-center gap-2">
              <span className="w-7 h-7 rounded-full bg-[#0C52AF] text-white text-xs flex items-center justify-center font-bold">1</span>
              Delivery Address
            </h2>
            <div className="space-y-3">
              <textarea placeholder="Street address, apartment, etc." value={form.address}
                onChange={e => setForm(f => ({ ...f, address: e.target.value }))}
                className="w-full p-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF] resize-none h-20" />
              <div className="grid grid-cols-2 gap-3">
                <input type="text" placeholder="City" value={form.city}
                  onChange={e => setForm(f => ({ ...f, city: e.target.value }))}
                  className="w-full p-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF]" />
                <input type="text" placeholder="Pincode" value={form.pincode}
                  onChange={e => setForm(f => ({ ...f, pincode: e.target.value }))}
                  className="w-full p-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF]" />
              </div>
              <input type="tel" placeholder="Phone number" value={form.phone}
                onChange={e => setForm(f => ({ ...f, phone: e.target.value }))}
                className="w-full p-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF]" />
            </div>
          </div>

          <div className="card-3d p-6">
            <h2 className="font-bold text-lg text-gray-800 mb-4 flex items-center gap-2">
              <span className="w-7 h-7 rounded-full bg-[#0C52AF] text-white text-xs flex items-center justify-center font-bold">2</span>
              Payment Method
            </h2>
            <div className="space-y-2">
              {[
                { value: 'COD', label: 'Cash on Delivery', icon: '💵', desc: 'Pay when you receive' },
                { value: 'UPI', label: 'UPI', icon: '📱', desc: 'Google Pay, PhonePe, Paytm' },
                { value: 'Card', label: 'Credit / Debit Card', icon: '💳', desc: 'Visa, Mastercard, RuPay' },
              ].map(m => (
                <label key={m.value} className={`flex items-center gap-4 p-4 rounded-xl border-2 cursor-pointer transition ${
                  payment === m.value ? 'border-[#0C52AF] bg-blue-50' : 'border-gray-100 hover:border-gray-200'
                }`}>
                  <input type="radio" name="payment" value={m.value} checked={payment === m.value}
                    onChange={() => setPayment(m.value)} className="accent-[#0C52AF]" />
                  <span className="text-xl">{m.icon}</span>
                  <div>
                    <p className="font-medium text-sm text-gray-800">{m.label}</p>
                    <p className="text-xs text-gray-400">{m.desc}</p>
                  </div>
                </label>
              ))}
            </div>
          </div>
        </div>

        <div className="lg:col-span-2">
          <div className="card-3d p-6 sticky top-24">
            <h3 className="font-bold text-lg text-gray-800 mb-4">Order Summary</h3>
            <div className="space-y-3 mb-4">
              {items.map(item => (
                <div key={item.product.id} className="flex items-center gap-3">
                  <img src={item.product.image_url} alt="" className="w-12 h-12 rounded-lg object-cover" />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-gray-800 truncate">{item.product.name}</p>
                    <p className="text-xs text-gray-400">Qty: {item.quantity}</p>
                  </div>
                  <p className="text-sm font-semibold">₹{item.product.price * item.quantity}</p>
                </div>
              ))}
            </div>
            <div className="border-t pt-3 space-y-2 text-sm">
              <div className="flex justify-between text-gray-500"><span>Subtotal</span><span>₹{total}</span></div>
              <div className="flex justify-between text-gray-500"><span>Delivery</span><span>{deliveryFee === 0 ? 'Free' : `₹${deliveryFee}`}</span></div>
              <div className="flex justify-between font-bold text-lg border-t pt-3 text-[#0A2061]">
                <span>Total</span><span>₹{grandTotal}</span>
              </div>
            </div>
            <button
              onClick={handlePlaceOrder}
              disabled={placing}
              className="w-full mt-6 btn-accent py-3.5 text-base disabled:opacity-60 disabled:cursor-not-allowed flex items-center justify-center gap-2"
            >
              {placing ? (
                <>
                  <svg className="animate-spin h-5 w-5" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none"/><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/></svg>
                  Processing...
                </>
              ) : payment === 'COD' ? 'Place Order' : `Pay ₹${grandTotal}`}
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default function CheckoutPage() {
  return (
    <Suspense fallback={
      <div className="max-w-5xl mx-auto px-4 py-8">
        <div className="animate-pulse space-y-6">
          <div className="h-8 w-48 shimmer" />
          <div className="h-64 rounded-2xl shimmer" />
        </div>
      </div>
    }>
      <CheckoutContent />
    </Suspense>
  )
}
