'use client'

import { useState } from 'react'
import { useAdminStore, type AdminSlider } from '@/lib/admin/store'
import { useToast } from '@/components/toast'

export default function AdminSlidersPage() {
  const { sliders, updateSliders } = useAdminStore()
  const { showToast } = useToast()
  const [form, setForm] = useState<Partial<AdminSlider>>({})
  const [editing, setEditing] = useState<string | null>(null)
  const [showForm, setShowForm] = useState(false)

  const openNew = () => { setForm({ title: '', subtitle: '', image: '', link: '/products', order: sliders.length + 1, active: true }); setEditing(null); setShowForm(true) }
  const openEdit = (s: AdminSlider) => { setForm({ ...s }); setEditing(s.id); setShowForm(true) }

  const save = () => {
    if (!form.title || !form.image) { showToast('Title and image are required', 'error'); return }
    if (editing) {
      updateSliders(prev => prev.map(s => s.id === editing ? { ...s, ...form } as AdminSlider : s))
      showToast('Slider updated')
    } else {
      updateSliders(prev => [...prev, { id: `sld-${Date.now()}`, title: form.title!, subtitle: form.subtitle || '', image: form.image!, link: form.link || '/products', order: form.order || prev.length + 1, active: form.active ?? true }])
      showToast('Slider created')
    }
    setShowForm(false)
  }

  const toggle = (id: string) => {
    updateSliders(prev => prev.map(s => s.id === id ? { ...s, active: !s.active } : s))
  }

  const remove = (id: string) => {
    if (!confirm('Delete this slider?')) return
    updateSliders(prev => prev.filter(s => s.id !== id))
    showToast('Slider deleted', 'info')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div><h1 className="text-2xl font-bold text-[#0A2061]">Sliders</h1><p className="text-sm text-gray-400">{sliders.filter(s => s.active).length} active of {sliders.length}</p></div>
        <button onClick={openNew} className="btn-primary text-sm px-4 py-2.5">+ New Slider</button>
      </div>

      {showForm && (
        <div className="fixed inset-0 z-50 bg-black/30 flex items-start justify-center pt-20" onClick={() => setShowForm(false)}>
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg p-6 m-4" onClick={e => e.stopPropagation()}>
            <h2 className="font-bold text-lg mb-4">{editing ? 'Edit' : 'New'} Slider</h2>
            <div className="space-y-3 text-sm">
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Title</label><input value={form.title || ''} onChange={e => setForm(f => ({ ...f, title: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Subtitle</label><input value={form.subtitle || ''} onChange={e => setForm(f => ({ ...f, subtitle: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Image URL</label><input value={form.image || ''} onChange={e => setForm(f => ({ ...f, image: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Link</label><input value={form.link || ''} onChange={e => setForm(f => ({ ...f, link: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Order</label><input type="number" value={form.order || 0} onChange={e => setForm(f => ({ ...f, order: Number(e.target.value) }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <label className="flex items-center gap-2">
                <input type="checkbox" checked={form.active ?? true} onChange={e => setForm(f => ({ ...f, active: e.target.checked }))} className="accent-[#0C52AF]" />
                <span className="text-xs font-medium text-gray-600">Active</span>
              </label>
            </div>
            <div className="flex justify-end gap-3 mt-6">
              <button onClick={() => setShowForm(false)} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-50">Cancel</button>
              <button onClick={save} className="btn-primary text-sm px-6 py-2.5">{editing ? 'Update' : 'Create'}</button>
            </div>
          </div>
        </div>
      )}

      <div className="space-y-4">
        {sliders.sort((a, b) => a.order - b.order).map(s => (
          <div key={s.id} className="card-3d overflow-hidden flex">
            <img src={s.image} alt={s.title} className="w-48 object-cover bg-gray-50" />
            <div className="flex-1 p-4 flex flex-col justify-between">
              <div>
                <div className="flex items-center gap-2 mb-1">
                  <p className="font-bold text-gray-800">{s.title}</p>
                  <span className={`text-xs px-2 py-0.5 rounded-full ${s.active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>{s.active ? 'Active' : 'Inactive'}</span>
                </div>
                <p className="text-sm text-gray-500">{s.subtitle}</p>
                <p className="text-xs text-gray-400 mt-1">Order: {s.order} · Link: {s.link}</p>
              </div>
              <div className="flex gap-3 mt-2">
                <button onClick={() => openEdit(s)} className="text-xs text-[#0C52AF] hover:underline">Edit</button>
                <button onClick={() => toggle(s.id)} className="text-xs text-gray-500 hover:text-[#0C52AF]">{s.active ? 'Deactivate' : 'Activate'}</button>
                <button onClick={() => remove(s.id)} className="text-xs text-red-500 hover:underline">Delete</button>
              </div>
            </div>
          </div>
        ))}
        {sliders.length === 0 && <p className="text-center text-gray-400 py-12">No sliders yet</p>}
      </div>
    </div>
  )
}
