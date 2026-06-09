'use client'

import { useAdminStore } from '@/lib/admin/store'
import { useToast } from '@/components/toast'
import Link from 'next/link'

const statusColors: Record<string, string> = {
  paid: 'bg-green-100 text-green-700',
  pending: 'bg-orange-100 text-orange-700',
  overdue: 'bg-red-100 text-red-700',
}

export default function AdminInvoicesPage() {
  const { invoices, orders, updateInvoices } = useAdminStore()
  const { showToast } = useToast()

  const markPaid = (id: string) => {
    updateInvoices(prev => prev.map(inv => inv.id === id ? { ...inv, status: 'paid' } : inv))
    showToast('Invoice marked as paid')
  }

  const totalPending = invoices.filter(inv => inv.status === 'pending').reduce((s, inv) => s + inv.total, 0)
  const totalPaid = invoices.filter(inv => inv.status === 'paid').reduce((s, inv) => s + inv.total, 0)

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div><h1 className="text-2xl font-bold text-[#0A2061]">Invoices</h1><p className="text-sm text-gray-400">{invoices.length} total</p></div>
      </div>

      {/* Summary */}
      <div className="grid grid-cols-3 gap-4 mb-6">
        <div className="card-3d p-4">
          <p className="text-xs text-gray-500">Total Paid</p>
          <p className="text-2xl font-bold text-green-600">₹{totalPaid.toLocaleString()}</p>
        </div>
        <div className="card-3d p-4">
          <p className="text-xs text-gray-500">Pending</p>
          <p className="text-2xl font-bold text-orange-600">₹{totalPending.toLocaleString()}</p>
        </div>
        <div className="card-3d p-4">
          <p className="text-xs text-gray-500">Total Revenue</p>
          <p className="text-2xl font-bold text-[#0C52AF]">₹{(totalPaid + totalPending).toLocaleString()}</p>
        </div>
      </div>

      <div className="card-3d overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50 text-left">
              <th className="p-3 font-semibold text-gray-600">Invoice</th>
              <th className="p-3 font-semibold text-gray-600">Order</th>
              <th className="p-3 font-semibold text-gray-600">Customer</th>
              <th className="p-3 font-semibold text-gray-600">Items</th>
              <th className="p-3 font-semibold text-gray-600">Total</th>
              <th className="p-3 font-semibold text-gray-600">Status</th>
              <th className="p-3 font-semibold text-gray-600">Due Date</th>
              <th className="p-3 font-semibold text-gray-600 text-right">Actions</th>
            </tr>
          </thead>
          <tbody>
            {invoices.length === 0 ? (
              <tr><td colSpan={8} className="p-8 text-center text-gray-400">No invoices yet</td></tr>
            ) : invoices.map(inv => (
              <tr key={inv.id} className="border-t border-gray-50 hover:bg-blue-50/30 transition">
                <td className="p-3 font-medium text-gray-800">{inv.id}</td>
                <td className="p-3 text-gray-500">{inv.orderId}</td>
                <td className="p-3 text-gray-800">{inv.customer}</td>
                <td className="p-3 text-gray-500">{inv.items}</td>
                <td className="p-3 font-semibold">₹{inv.total}</td>
                <td className="p-3">
                  <span className={`text-xs font-semibold px-2 py-0.5 rounded-full capitalize ${statusColors[inv.status]}`}>{inv.status}</span>
                </td>
                <td className="p-3 text-xs text-gray-400">{inv.dueDate}</td>
                <td className="p-3 text-right">
                  {inv.status === 'pending' && <button onClick={() => markPaid(inv.id)} className="text-xs text-green-600 hover:underline mr-2">Mark Paid</button>}
                  <button onClick={() => window.print()} className="text-xs text-[#0C52AF] hover:underline">Print</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
