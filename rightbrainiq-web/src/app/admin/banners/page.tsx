'use client'

import { useState } from 'react'
import { useAdminStore, type AdminBanner } from '@/lib/admin/store'
import { useToast } from '@/components/toast'

export default function AdminBannersPage() {
  const { banners, updateBanners } = useAdminStore()
  const { showToast } = useToast()
  const [form, setForm] = useState<Partial<AdminBanner>>({})
  const [editing, setEditing] = useState<string | null>(null)
  const [showForm, setShowForm] = useState(false)

  const openNew = () => { setForm({ title: '', image: '', link: '/products', position: 'home-top', active: true }); setEditing(null); setShowForm(true) }
  const openEdit = (b: AdminBanner) => { setForm({ ...b }); setEditing(b.id); setShowForm(true) }

  const save = () => {
    if (!form.title || !form.image) { showToast('Title and image are required', 'error'); return }
    if (editing) {
      updateBanners(prev => prev.map(b => b.id === editing ? { ...b, ...form } as AdminBanner : b))
      showToast('Banner updated')
    } else {
      updateBanners(prev => [...prev, { id: `bnr-${Date.now()}`, title: form.title!, image: form.image!, link: form.link || '/products', position: form.position || 'home-top', active: form.active ?? true }])
      showToast('Banner created')
    }
    setShowForm(false)
  }

  const toggle = (id: string) => { updateBanners(prev => prev.map(b => b.id === id ? { ...b, active: !b.active } : b)) }
  const remove = (id: string) => { if (confirm('Delete this banner?')) { updateBanners(prev => prev.filter(b => b.id !== id)); showToast('Banner deleted', 'info') } }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div><h1 className="text-2xl font-bold text-[#0A2061]">Banners</h1><p className="text-sm text-gray-400">{banners.filter(b => b.active).length} active</p></div>
        <button onClick={openNew} className="btn-primary text-sm px-4 py-2.5">+ New Banner</button>
      </div>

      {showForm && (
        <div className="fixed inset-0 z-50 bg-black/30 flex items-start justify-center pt-20" onClick={() => setShowForm(false)}>
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg p-6 m-4" onClick={e => e.stopPropagation()}>
            <h2 className="font-bold text-lg mb-4">{editing ? 'Edit' : 'New'} Banner</h2>
            <div className="space-y-3 text-sm">
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Title</label><input value={form.title || ''} onChange={e => setForm(f => ({ ...f, title: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Image URL</label><input value={form.image || ''} onChange={e => setForm(f => ({ ...f, image: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Link</label><input value={form.link || ''} onChange={e => setForm(f => ({ ...f, link: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Position</label>
                <select value={form.position || 'home-top'} onChange={e => setForm(f => ({ ...f, position: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]">
                  <option value="home-top">Home Top</option>
                  <option value="home-middle">Home Middle</option>
                  <option value="home-bottom">Home Bottom</option>
                </select>
              </div>
              <label className="flex items-center gap-2"><input type="checkbox" checked={form.active ?? true} onChange={e => setForm(f => ({ ...f, active: e.target.checked }))} className="accent-[#0C52AF]" /><span className="text-xs font-medium text-gray-600">Active</span></label>
            </div>
            <div className="flex justify-end gap-3 mt-6">
              <button onClick={() => setShowForm(false)} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-50">Cancel</button>
              <button onClick={save} className="btn-primary text-sm px-6 py-2.5">{editing ? 'Update' : 'Create'}</button>
            </div>
          </div>
        </div>
      )}

      <div className="grid md:grid-cols-2 gap-4">
        {banners.map(b => (
          <div key={b.id} className="card-3d overflow-hidden">
            <img src={b.image} alt={b.title} className="w-full h-40 object-cover" />
            <div className="p-4">
              <div className="flex items-center gap-2 mb-1">
                <p className="font-bold text-sm text-gray-800">{b.title}</p>
                <span className={`text-xs px-2 py-0.5 rounded-full ${b.active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>{b.active ? 'Active' : 'Inactive'}</span>
              </div>
              <p className="text-xs text-gray-400 mb-2">Position: {b.position} · Link: {b.link}</p>
              <div className="flex gap-3">
                <button onClick={() => openEdit(b)} className="text-xs text-[#0C52AF] hover:underline">Edit</button>
                <button onClick={() => toggle(b.id)} className="text-xs text-gray-500 hover:text-[#0C52AF]">{b.active ? 'Deactivate' : 'Activate'}</button>
                <button onClick={() => remove(b.id)} className="text-xs text-red-500 hover:underline">Delete</button>
              </div>
            </div>
          </div>
        ))}
        {banners.length === 0 && <p className="col-span-2 text-center text-gray-400 py-12">No banners yet</p>}
      </div>
    </div>
  )
}
