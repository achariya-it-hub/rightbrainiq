'use client'

import { useState } from 'react'
import Link from 'next/link'
import { useAdminStore, type AdminProduct } from '@/lib/admin/store'
import { useToast } from '@/components/toast'

const emptyProduct = (): AdminProduct => ({
  id: '', name: '', slug: '', category_slug: 'smart-start-cards', price: 340, currency: '₹',
  image_url: '', image_url2: null, card_count: 20, description: '', color: 'red', stock: 50, createdAt: new Date().toISOString().split('T')[0],
})

const colors = ['red', 'orange', 'yellow', 'green', 'teal', 'blue', 'purple', 'pink', 'indigo']

export default function AdminProductsPage() {
  const { products, categories, updateProducts } = useAdminStore()
  const { showToast } = useToast()
  const [editingId, setEditingId] = useState<string | null>(null)
  const [form, setForm] = useState<AdminProduct>(emptyProduct())
  const [showForm, setShowForm] = useState(false)
  const [search, setSearch] = useState('')

  const filtered = products.filter(p => p.name.toLowerCase().includes(search.toLowerCase()))

  const openNew = () => {
    const newId = `p-${Date.now()}`
    setForm({ ...emptyProduct(), id: newId, slug: '', createdAt: new Date().toISOString().split('T')[0] })
    setEditingId(null)
    setShowForm(true)
  }

  const openEdit = (p: AdminProduct) => {
    setForm({ ...p })
    setEditingId(p.id)
    setShowForm(true)
  }

  const save = () => {
    if (!form.name || !form.price) { showToast('Name and price are required', 'error'); return }
    const slug = form.slug || form.name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')
    const product = { ...form, slug }
    if (editingId) {
      updateProducts(prev => prev.map(p => p.id === editingId ? product : p))
      showToast('Product updated')
    } else {
      updateProducts(prev => [...prev, product])
      showToast('Product created')
    }
    setShowForm(false)
  }

  const remove = (id: string) => {
    if (!confirm('Delete this product?')) return
    updateProducts(prev => prev.filter(p => p.id !== id))
    showToast('Product deleted', 'info')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-[#0A2061]">Products</h1>
          <p className="text-sm text-gray-400">{products.length} total</p>
        </div>
        <div className="flex items-center gap-3">
          <input type="text" placeholder="Search products..." value={search} onChange={e => setSearch(e.target.value)}
            className="p-2.5 border border-gray-200 rounded-xl text-sm w-48 focus:outline-none focus:border-[#0C52AF]" />
          <button onClick={openNew} className="btn-primary text-sm px-4 py-2.5">+ New Product</button>
        </div>
      </div>

      {/* Form Modal */}
      {showForm && (
        <div className="fixed inset-0 z-50 bg-black/30 flex items-start justify-center pt-12 overflow-y-auto" onClick={() => setShowForm(false)}>
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-2xl p-6 m-4" onClick={e => e.stopPropagation()}>
            <div className="flex items-center justify-between mb-4">
              <h2 className="font-bold text-lg">{editingId ? 'Edit Product' : 'New Product'}</h2>
              <button onClick={() => setShowForm(false)} className="p-1 text-gray-400 hover:text-gray-600"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg></button>
            </div>
            <div className="grid grid-cols-2 gap-4 text-sm">
              <div className="col-span-2"><label className="block text-xs font-medium text-gray-600 mb-1">Name</label><input value={form.name} onChange={e => setForm(f => ({ ...f, name: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Slug</label><input value={form.slug} onChange={e => setForm(f => ({ ...f, slug: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Category</label>
                <select value={form.category_slug} onChange={e => setForm(f => ({ ...f, category_slug: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]">
                  {categories.map(c => <option key={c.slug} value={c.slug}>{c.name}</option>)}
                </select>
              </div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Price (₹)</label><input type="number" value={form.price} onChange={e => setForm(f => ({ ...f, price: Number(e.target.value) }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Card Count</label><input type="number" value={form.card_count} onChange={e => setForm(f => ({ ...f, card_count: Number(e.target.value) }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Stock</label><input type="number" value={form.stock} onChange={e => setForm(f => ({ ...f, stock: Number(e.target.value) }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Color</label>
                <select value={form.color} onChange={e => setForm(f => ({ ...f, color: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]">
                  {colors.map(c => <option key={c} value={c}>{c}</option>)}
                </select>
              </div>
              <div className="col-span-2"><label className="block text-xs font-medium text-gray-600 mb-1">Image URL</label><input value={form.image_url} onChange={e => setForm(f => ({ ...f, image_url: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div className="col-span-2"><label className="block text-xs font-medium text-gray-600 mb-1">Image URL 2 (optional)</label><input value={form.image_url2 || ''} onChange={e => setForm(f => ({ ...f, image_url2: e.target.value || null }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div className="col-span-2"><label className="block text-xs font-medium text-gray-600 mb-1">Description</label><textarea value={form.description} onChange={e => setForm(f => ({ ...f, description: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF] resize-none h-20" /></div>
            </div>
            <div className="flex justify-end gap-3 mt-6">
              <button onClick={() => setShowForm(false)} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-50 transition">Cancel</button>
              <button onClick={save} className="btn-primary text-sm px-6 py-2.5">{editingId ? 'Update' : 'Create'} Product</button>
            </div>
          </div>
        </div>
      )}

      {/* Table */}
      <div className="card-3d overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50 text-left">
              <th className="p-3 font-semibold text-gray-600">Product</th>
              <th className="p-3 font-semibold text-gray-600">Category</th>
              <th className="p-3 font-semibold text-gray-600">Price</th>
              <th className="p-3 font-semibold text-gray-600">Cards</th>
              <th className="p-3 font-semibold text-gray-600">Stock</th>
              <th className="p-3 font-semibold text-gray-600">Date</th>
              <th className="p-3 font-semibold text-gray-600 text-right">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filtered.length === 0 ? (
              <tr><td colSpan={7} className="p-8 text-center text-gray-400">No products found</td></tr>
            ) : filtered.map(p => (
              <tr key={p.id} className="border-t border-gray-50 hover:bg-blue-50/30 transition">
                <td className="p-3">
                  <div className="flex items-center gap-3">
                    <img src={p.image_url} alt={p.name} className="w-10 h-10 rounded-lg object-cover bg-gray-50" />
                    <div>
                      <p className="font-medium text-gray-800">{p.name}</p>
                      <p className="text-xs text-gray-400">{p.slug}</p>
                    </div>
                  </div>
                </td>
                <td className="p-3 text-gray-500 text-xs">{p.category_slug}</td>
                <td className="p-3 font-semibold">₹{p.price}</td>
                <td className="p-3 text-gray-500">{p.card_count}</td>
                <td className="p-3">
                  <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${p.stock < 10 ? 'bg-red-100 text-red-700' : p.stock < 25 ? 'bg-orange-100 text-orange-700' : 'bg-green-100 text-green-700'}`}>{p.stock}</span>
                </td>
                <td className="p-3 text-xs text-gray-400">{p.createdAt}</td>
                <td className="p-3 text-right">
                  <button onClick={() => openEdit(p)} className="text-xs text-[#0C52AF] hover:underline mr-3">Edit</button>
                  <button onClick={() => remove(p.id)} className="text-xs text-red-500 hover:underline">Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
