'use client'

import { useState } from 'react'
import { useAdminStore, type AdminCategory } from '@/lib/admin/store'
import { useToast } from '@/components/toast'

export default function AdminCategoriesPage() {
  const { categories, updateCategories } = useAdminStore()
  const { showToast } = useToast()
  const [form, setForm] = useState<Partial<AdminCategory>>({})
  const [editing, setEditing] = useState<number | null>(null)
  const [showForm, setShowForm] = useState(false)

  const openNew = () => { setForm({ name: '', slug: '', product_count: 0, image_url: '', description: '' }); setEditing(null); setShowForm(true) }
  const openEdit = (c: AdminCategory) => { setForm({ ...c }); setEditing(c.id); setShowForm(true) }

  const save = () => {
    if (!form.name) { showToast('Name is required', 'error'); return }
    const slug = form.slug || form.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')
    if (editing) {
      updateCategories(prev => prev.map(c => c.id === editing ? { ...c, ...form, slug } as AdminCategory : c))
      showToast('Category updated')
    } else {
      updateCategories(prev => [...prev, { id: Date.now(), name: form.name!, slug, product_count: form.product_count || 0, image_url: form.image_url || '', description: form.description || '' }])
      showToast('Category created')
    }
    setShowForm(false)
  }

  const remove = (id: number) => {
    if (!confirm('Delete this category?')) return
    updateCategories(prev => prev.filter(c => c.id !== id))
    showToast('Category deleted', 'info')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div><h1 className="text-2xl font-bold text-[#0A2061]">Categories</h1><p className="text-sm text-gray-400">{categories.length} categories</p></div>
        <button onClick={openNew} className="btn-primary text-sm px-4 py-2.5">+ New Category</button>
      </div>

      {showForm && (
        <div className="fixed inset-0 z-50 bg-black/30 flex items-start justify-center pt-20" onClick={() => setShowForm(false)}>
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg p-6 m-4" onClick={e => e.stopPropagation()}>
            <h2 className="font-bold text-lg mb-4">{editing ? 'Edit' : 'New'} Category</h2>
            <div className="space-y-3 text-sm">
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Name</label><input value={form.name || ''} onChange={e => setForm(f => ({ ...f, name: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Slug</label><input value={form.slug || ''} onChange={e => setForm(f => ({ ...f, slug: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Product Count</label><input type="number" value={form.product_count || 0} onChange={e => setForm(f => ({ ...f, product_count: Number(e.target.value) }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Image URL</label><input value={form.image_url || ''} onChange={e => setForm(f => ({ ...f, image_url: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Description</label><textarea value={form.description || ''} onChange={e => setForm(f => ({ ...f, description: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF] resize-none h-20" /></div>
            </div>
            <div className="flex justify-end gap-3 mt-6">
              <button onClick={() => setShowForm(false)} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-50">Cancel</button>
              <button onClick={save} className="btn-primary text-sm px-6 py-2.5">{editing ? 'Update' : 'Create'}</button>
            </div>
          </div>
        </div>
      )}

      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
        {categories.map(c => (
          <div key={c.id} className="card-3d p-4">
            <div className="flex items-center gap-3 mb-3">
              <img src={c.image_url} alt={c.name} className="w-14 h-14 rounded-xl object-cover bg-gray-50" />
              <div className="flex-1 min-w-0">
                <p className="font-bold text-sm text-gray-800 truncate">{c.name}</p>
                <p className="text-xs text-gray-400">{c.product_count} products</p>
              </div>
            </div>
            <p className="text-xs text-gray-500 line-clamp-2 mb-3">{c.description}</p>
            <div className="flex gap-2">
              <button onClick={() => openEdit(c)} className="text-xs text-[#0C52AF] hover:underline">Edit</button>
              <button onClick={() => remove(c.id)} className="text-xs text-red-500 hover:underline">Delete</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
