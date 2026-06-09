'use client'

import { useState } from 'react'
import { useAdminStore, type AdminUser } from '@/lib/admin/store'
import { useToast } from '@/components/toast'

export default function AdminUsersPage() {
  const { users, updateUsers } = useAdminStore()
  const { showToast } = useToast()
  const [form, setForm] = useState<Partial<AdminUser>>({})
  const [editing, setEditing] = useState<string | null>(null)
  const [showForm, setShowForm] = useState(false)

  const openNew = () => { setForm({ name: '', email: '', phone: '', role: 'user' }); setEditing(null); setShowForm(true) }
  const openEdit = (u: AdminUser) => { setForm({ ...u }); setEditing(u.id); setShowForm(true) }

  const save = () => {
    if (!form.name || !form.email) { showToast('Name and email are required', 'error'); return }
    if (editing) {
      updateUsers(prev => prev.map(u => u.id === editing ? { ...u, ...form } as AdminUser : u))
      showToast('User updated')
    } else {
      updateUsers(prev => [...prev, { id: `usr-${Date.now()}`, name: form.name!, email: form.email!, phone: form.phone || '', role: form.role || 'user', orders: 0, createdAt: new Date().toISOString().split('T')[0] }])
      showToast('User created')
    }
    setShowForm(false)
  }

  const remove = (id: string) => {
    if (id === 'usr-1') { showToast('Cannot delete the main admin', 'error'); return }
    if (!confirm('Delete this user?')) return
    updateUsers(prev => prev.filter(u => u.id !== id))
    showToast('User deleted', 'info')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div><h1 className="text-2xl font-bold text-[#0A2061]">Users</h1><p className="text-sm text-gray-400">{users.length} total ({users.filter(u => u.role === 'admin').length} admins)</p></div>
        <button onClick={openNew} className="btn-primary text-sm px-4 py-2.5">+ New User</button>
      </div>

      {showForm && (
        <div className="fixed inset-0 z-50 bg-black/30 flex items-start justify-center pt-20" onClick={() => setShowForm(false)}>
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg p-6 m-4" onClick={e => e.stopPropagation()}>
            <h2 className="font-bold text-lg mb-4">{editing ? 'Edit' : 'New'} User</h2>
            <div className="space-y-3 text-sm">
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Name</label><input value={form.name || ''} onChange={e => setForm(f => ({ ...f, name: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Email</label><input type="email" value={form.email || ''} onChange={e => setForm(f => ({ ...f, email: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Phone</label><input value={form.phone || ''} onChange={e => setForm(f => ({ ...f, phone: e.target.value }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" /></div>
              <div><label className="block text-xs font-medium text-gray-600 mb-1">Role</label>
                <select value={form.role || 'user'} onChange={e => setForm(f => ({ ...f, role: e.target.value as 'admin' | 'user' }))} className="w-full p-2.5 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]">
                  <option value="user">User</option>
                  <option value="admin">Admin</option>
                </select>
              </div>
            </div>
            <div className="flex justify-end gap-3 mt-6">
              <button onClick={() => setShowForm(false)} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-50">Cancel</button>
              <button onClick={save} className="btn-primary text-sm px-6 py-2.5">{editing ? 'Update' : 'Create'}</button>
            </div>
          </div>
        </div>
      )}

      <div className="card-3d overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50 text-left">
              <th className="p-3 font-semibold text-gray-600">User</th>
              <th className="p-3 font-semibold text-gray-600">Email</th>
              <th className="p-3 font-semibold text-gray-600">Phone</th>
              <th className="p-3 font-semibold text-gray-600">Role</th>
              <th className="p-3 font-semibold text-gray-600">Orders</th>
              <th className="p-3 font-semibold text-gray-600">Joined</th>
              <th className="p-3 font-semibold text-gray-600 text-right">Actions</th>
            </tr>
          </thead>
          <tbody>
            {users.map(u => (
              <tr key={u.id} className="border-t border-gray-50 hover:bg-blue-50/30 transition">
                <td className="p-3">
                  <div className="flex items-center gap-3">
                    <div className="w-9 h-9 rounded-full bg-gradient-to-br from-[#0C52AF] to-[#3496D3] text-white flex items-center justify-center text-sm font-bold">{u.name.charAt(0)}</div>
                    <span className="font-medium text-gray-800">{u.name}</span>
                  </div>
                </td>
                <td className="p-3 text-gray-500">{u.email}</td>
                <td className="p-3 text-gray-500">{u.phone}</td>
                <td className="p-3">
                  <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${u.role === 'admin' ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'}`}>{u.role}</span>
                </td>
                <td className="p-3 text-gray-500">{u.orders}</td>
                <td className="p-3 text-xs text-gray-400">{u.createdAt}</td>
                <td className="p-3 text-right">
                  <button onClick={() => openEdit(u)} className="text-xs text-[#0C52AF] hover:underline mr-3">Edit</button>
                  <button onClick={() => remove(u.id)} className="text-xs text-red-500 hover:underline">Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
