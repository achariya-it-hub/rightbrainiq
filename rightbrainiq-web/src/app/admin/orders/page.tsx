'use client'

import { useState } from 'react'
import { useAdminStore, type AdminOrder } from '@/lib/admin/store'
import { useToast } from '@/components/toast'

const statusColors: Record<string, string> = {
  pending: 'bg-orange-100 text-orange-700',
  confirmed: 'bg-purple-100 text-purple-700',
  shipped: 'bg-blue-100 text-blue-700',
  delivered: 'bg-green-100 text-green-700',
  cancelled: 'bg-red-100 text-red-700',
}

const nextStatus: Record<string, string> = {
  pending: 'confirmed',
  confirmed: 'shipped',
  shipped: 'delivered',
}

export default function AdminOrdersPage() {
  const { orders, updateOrders } = useAdminStore()
  const { showToast } = useToast()
  const [filter, setFilter] = useState<string>('all')
  const [viewId, setViewId] = useState<string | null>(null)
  const [editNotes, setEditNotes] = useState('')

  const filtered = filter === 'all' ? orders : orders.filter(o => o.status === filter)

  const advanceStatus = (id: string) => {
    updateOrders(prev => prev.map(o => {
      if (o.id !== id) return o
      const next = nextStatus[o.status]
      return next ? { ...o, status: next as AdminOrder['status'] } : o
    }))
    showToast('Order status updated')
  }

  const cancelOrder = (id: string) => {
    if (!confirm('Cancel this order?')) return
    updateOrders(prev => prev.map(o => o.id === id ? { ...o, status: 'cancelled' as AdminOrder['status'] } : o))
    showToast('Order cancelled', 'info')
  }

  const openView = (o: AdminOrder) => { setViewId(o.id); setEditNotes(o.notes) }
  const saveNotes = () => {
    updateOrders(prev => prev.map(o => o.id === viewId ? { ...o, notes: editNotes } : o))
    showToast('Notes saved')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div><h1 className="text-2xl font-bold text-[#0A2061]">Orders</h1><p className="text-sm text-gray-400">{orders.length} total</p></div>
        <div className="flex gap-2">
          {['all', 'pending', 'confirmed', 'shipped', 'delivered', 'cancelled'].map(s => (
            <button key={s} onClick={() => setFilter(s)}
              className={`px-3 py-1.5 rounded-lg text-xs font-medium capitalize transition ${
                filter === s ? 'bg-[#0C52AF] text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
              }`}>{s}</button>
          ))}
        </div>
      </div>

      {/* View Modal */}
      {viewId && (
        <div className="fixed inset-0 z-50 bg-black/30 flex items-start justify-center pt-12 overflow-y-auto" onClick={() => setViewId(null)}>
          {(() => {
            const o = orders.find(x => x.id === viewId)
            if (!o) return null
            return (
              <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg p-6 m-4" onClick={e => e.stopPropagation()}>
                <div className="flex items-center justify-between mb-4">
                  <h2 className="font-bold text-lg">{o.id}</h2>
                  <button onClick={() => setViewId(null)} className="p-1 text-gray-400 hover:text-gray-600"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg></button>
                </div>
                <div className="space-y-3 text-sm">
                  <div className="flex justify-between"><span className="text-gray-500">Status</span><span className={`text-xs font-semibold px-2 py-0.5 rounded-full capitalize ${statusColors[o.status]}`}>{o.status}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Date</span><span>{new Date(o.createdAt).toLocaleString()}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Payment</span><span>{o.paymentMethod}</span></div>
                  <div className="flex justify-between"><span className="text-gray-500">Total</span><span className="font-bold">₹{o.grandTotal}</span></div>
                  <hr />
                  <p className="font-semibold">Items</p>
                  {o.items.map((item, i) => (
                    <div key={i} className="flex justify-between text-sm"><span>{item.name} × {item.qty}</span><span>₹{item.price * item.qty}</span></div>
                  ))}
                  <hr />
                  <p className="font-semibold">Delivery</p>
                  <p className="text-gray-600">{o.address}, {o.city} - {o.pincode}</p>
                  <p className="text-gray-600">{o.phone}</p>
                  <p className="font-semibold mt-2">Notes</p>
                  <textarea value={editNotes} onChange={e => setEditNotes(e.target.value)} className="w-full p-2 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF] resize-none h-20" />
                  <button onClick={saveNotes} className="btn-primary text-sm px-4 py-2">Save Notes</button>
                </div>
              </div>
            )
          })()}
        </div>
      )}

      <div className="card-3d overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50 text-left">
              <th className="p-3 font-semibold text-gray-600">Order</th>
              <th className="p-3 font-semibold text-gray-600">Customer</th>
              <th className="p-3 font-semibold text-gray-600">Items</th>
              <th className="p-3 font-semibold text-gray-600">Total</th>
              <th className="p-3 font-semibold text-gray-600">Payment</th>
              <th className="p-3 font-semibold text-gray-600">Status</th>
              <th className="p-3 font-semibold text-gray-600">Date</th>
              <th className="p-3 font-semibold text-gray-600 text-right">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filtered.length === 0 ? (
              <tr><td colSpan={8} className="p-8 text-center text-gray-400">No orders found</td></tr>
            ) : filtered.map(o => (
              <tr key={o.id} className="border-t border-gray-50 hover:bg-blue-50/30 transition">
                <td className="p-3 font-medium text-gray-800">{o.id}</td>
                <td className="p-3">
                  <p className="text-gray-800">{o.email}</p>
                  <p className="text-xs text-gray-400">{o.phone}</p>
                </td>
                <td className="p-3 text-gray-500">{o.items.length}</td>
                <td className="p-3 font-semibold">₹{o.grandTotal}</td>
                <td className="p-3 text-xs text-gray-500">{o.paymentMethod}</td>
                <td className="p-3">
                  <span className={`text-xs font-semibold px-2 py-0.5 rounded-full capitalize ${statusColors[o.status]}`}>{o.status}</span>
                </td>
                <td className="p-3 text-xs text-gray-400">{new Date(o.createdAt).toLocaleDateString()}</td>
                <td className="p-3 text-right">
                  <button onClick={() => openView(o)} className="text-xs text-gray-500 hover:text-[#0C52AF] mr-2">View</button>
                  {nextStatus[o.status] && <button onClick={() => advanceStatus(o.id)} className="text-xs text-[#0C52AF] hover:underline mr-2">→ {nextStatus[o.status]}</button>}
                  {o.status !== 'cancelled' && o.status !== 'delivered' && <button onClick={() => cancelOrder(o.id)} className="text-xs text-red-500 hover:underline">Cancel</button>}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
