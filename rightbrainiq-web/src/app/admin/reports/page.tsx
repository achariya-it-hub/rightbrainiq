'use client'

import { useState, useMemo } from 'react'
import { useAdminStore } from '@/lib/admin/store'

const tabs = [
  { id: 'sales', label: 'Sales Report', icon: '💰' },
  { id: 'orders', label: 'Orders Report', icon: '🛵' },
  { id: 'cancelled', label: 'Cancelled Orders', icon: '❌' },
  { id: 'top', label: 'Most Sold Items', icon: '🏆' },
  { id: 'bottom', label: 'Least Sold Items', icon: '📉' },
  { id: 'users', label: 'User Report', icon: '👥' },
  { id: 'lms', label: 'LMS Report', icon: '🎓' },
  { id: 'offers', label: 'Offers Redeemed', icon: '🎁' },
]

export default function AdminReportsPage() {
  const [activeTab, setActiveTab] = useState('sales')
  const { salesReport, lmsReport, offersReport, orders, products, users, topProducts, salesSummary } = useAdminStore()

  const cancelledOrders = useMemo(() => orders.filter(o => o.status === 'cancelled'), [orders])

  const bottomProducts = useMemo(() => {
    const inOrders = new Set(topProducts.map(p => p.productId))
    const unsold = products
      .filter(p => !inOrders.has(p.id))
      .map(p => ({ productId: p.id, name: p.name, category: p.category_slug, totalQty: 0, totalRevenue: 0 }))
    return [...topProducts].sort((a, b) => a.totalQty - b.totalQty).concat(unsold).slice(0, 15)
  }, [topProducts, products])

  const userReport = useMemo(() => {
    const admins = users.filter(u => u.role === 'admin').length
    const regular = users.filter(u => u.role === 'user').length
    const withOrders = users.filter(u => u.orders > 0).length
    const totalSpent = orders
      .filter(o => o.status !== 'cancelled')
      .reduce((s, o) => s + o.grandTotal, 0)
    return { admins, regular, total: users.length, withOrders, totalSpent }
  }, [users, orders])

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-[#0A2061]">Reports</h1>
          <p className="text-sm text-gray-400">All analytics and insights at a glance</p>
        </div>
      </div>

      {/* Tab Bar */}
      <div className="flex flex-wrap gap-2 mb-6">
        {tabs.map(t => (
          <button key={t.id} onClick={() => setActiveTab(t.id)}
            className={`flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-medium transition ${
              activeTab === t.id ? 'bg-[#0C52AF] text-white shadow-md' : 'bg-white text-gray-600 hover:bg-gray-100 border border-gray-200'
            }`}>
            <span>{t.icon}</span>
            <span>{t.label}</span>
          </button>
        ))}
      </div>

      {/* ─── Sales Report ─── */}
      {activeTab === 'sales' && (
        <div className="space-y-6">
          <div className="grid grid-cols-4 gap-4">
            {[
              { label: 'Total Revenue', value: `₹${salesSummary.totalRevenue.toLocaleString()}`, color: 'from-emerald-500 to-emerald-600' },
              { label: 'Total Items Sold', value: salesSummary.totalItemsSold, color: 'from-blue-500 to-blue-600' },
              { label: 'Avg Order Value', value: `₹${salesSummary.completedOrders ? Math.round(salesSummary.totalRevenue / salesSummary.completedOrders) : 0}`, color: 'from-purple-500 to-purple-600' },
              { label: 'Cancellation Rate', value: `${salesSummary.totalOrders ? ((salesSummary.cancelledOrders / salesSummary.totalOrders) * 100).toFixed(1) : 0}%`, color: 'from-orange-500 to-orange-600' },
            ].map(c => (
              <div key={c.label} className={`bg-gradient-to-br ${c.color} rounded-2xl p-4 text-white`}>
                <p className="text-2xl font-bold">{c.value}</p>
                <p className="text-xs text-white/70 mt-1">{c.label}</p>
              </div>
            ))}
          </div>

          <div className="card-3d p-5">
            <h2 className="font-bold text-gray-800 mb-4">Monthly Sales Trend</h2>
            <div className="space-y-3">
              {salesReport.map(s => {
                const maxRevenue = Math.max(...salesReport.map(x => x.revenue))
                const pct = (s.revenue / maxRevenue) * 100
                return (
                  <div key={s.month} className="flex items-center gap-4">
                    <span className="text-xs text-gray-500 w-16 flex-shrink-0">{s.month}</span>
                    <div className="flex-1 bg-gray-100 rounded-full h-6 overflow-hidden">
                      <div className="h-full rounded-full bg-gradient-to-r from-[#0C52AF] to-[#3496D3] transition-all duration-500 flex items-center justify-end pr-2"
                        style={{ width: `${pct}%` }}>
                        <span className="text-xs text-white font-semibold">{pct > 15 ? `₹${s.revenue.toLocaleString()}` : ''}</span>
                      </div>
                    </div>
                    <span className="text-xs text-gray-400 w-16 text-right">{s.orders} orders</span>
                  </div>
                )
              })}
            </div>
          </div>

          <div className="card-3d overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 text-left">
                  <th className="p-3 font-semibold text-gray-600">Month</th>
                  <th className="p-3 font-semibold text-gray-600">Revenue</th>
                  <th className="p-3 font-semibold text-gray-600">Orders</th>
                  <th className="p-3 font-semibold text-gray-600">Cancelled</th>
                  <th className="p-3 font-semibold text-gray-600">Items Sold</th>
                  <th className="p-3 font-semibold text-gray-600">Avg Order Value</th>
                </tr>
              </thead>
              <tbody>
                {salesReport.map(s => (
                  <tr key={s.month} className="border-t border-gray-50 hover:bg-blue-50/30">
                    <td className="p-3 font-medium text-gray-800">{s.month}</td>
                    <td className="p-3 font-semibold text-green-600">₹{s.revenue.toLocaleString()}</td>
                    <td className="p-3 text-gray-600">{s.orders}</td>
                    <td className="p-3 text-gray-600">{s.cancelled}</td>
                    <td className="p-3 text-gray-600">{s.itemsSold}</td>
                    <td className="p-3 text-gray-600">₹{s.orders ? Math.round(s.revenue / s.orders) : 0}</td>
                  </tr>
                ))}
                <tr className="border-t-2 border-gray-200 bg-gray-50 font-semibold">
                  <td className="p-3 text-gray-800">Total</td>
                  <td className="p-3 text-green-600">₹{salesReport.reduce((s, r) => s + r.revenue, 0).toLocaleString()}</td>
                  <td className="p-3 text-gray-800">{salesReport.reduce((s, r) => s + r.orders, 0)}</td>
                  <td className="p-3 text-gray-800">{salesReport.reduce((s, r) => s + r.cancelled, 0)}</td>
                  <td className="p-3 text-gray-800">{salesReport.reduce((s, r) => s + r.itemsSold, 0)}</td>
                  <td className="p-3 text-gray-800">—</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ─── Orders Report ─── */}
      {activeTab === 'orders' && (
        <div className="space-y-6">
          <div className="grid grid-cols-5 gap-4">
            {[
              { label: 'Total Orders', value: salesSummary.totalOrders, color: 'from-blue-500 to-blue-600' },
              { label: 'Pending', value: orders.filter(o => o.status === 'pending').length, color: 'from-orange-500 to-orange-600' },
              { label: 'Confirmed', value: orders.filter(o => o.status === 'confirmed').length, color: 'from-purple-500 to-purple-600' },
              { label: 'Shipped', value: orders.filter(o => o.status === 'shipped').length, color: 'from-cyan-500 to-cyan-600' },
              { label: 'Delivered', value: orders.filter(o => o.status === 'delivered').length, color: 'from-green-500 to-green-600' },
            ].map(c => (
              <div key={c.label} className={`bg-gradient-to-br ${c.color} rounded-2xl p-4 text-white`}>
                <p className="text-2xl font-bold">{c.value}</p>
                <p className="text-xs text-white/70 mt-1">{c.label}</p>
              </div>
            ))}
          </div>

          <div className="card-3d p-5">
            <h2 className="font-bold text-gray-800 mb-4">Order Status Breakdown</h2>
            <div className="flex items-end gap-3 h-40">
              {['pending', 'confirmed', 'shipped', 'delivered', 'cancelled'].map(status => {
                const count = orders.filter(o => o.status === status).length
                const maxCount = Math.max(1, ...['pending', 'confirmed', 'shipped', 'delivered', 'cancelled'].map(s => orders.filter(o => o.status === s).length))
                const pct = (count / maxCount) * 100
                const colors: Record<string, string> = { pending: 'bg-orange-400', confirmed: 'bg-purple-400', shipped: 'bg-cyan-400', delivered: 'bg-green-400', cancelled: 'bg-red-400' }
                return (
                  <div key={status} className="flex-1 flex flex-col items-center gap-2">
                    <div className="w-full bg-gray-100 rounded-lg relative" style={{ height: '120px' }}>
                      <div className={`absolute bottom-0 left-0 right-0 rounded-lg transition-all duration-500 ${colors[status]}`}
                        style={{ height: `${pct}%` }} />
                    </div>
                    <span className="text-xs font-medium text-gray-600 capitalize">{status}</span>
                    <span className="text-sm font-bold text-gray-800">{count}</span>
                  </div>
                )
              })}
            </div>
          </div>

          <div className="card-3d overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 text-left">
                  <th className="p-3 font-semibold text-gray-600">Order ID</th>
                  <th className="p-3 font-semibold text-gray-600">Status</th>
                  <th className="p-3 font-semibold text-gray-600">Payment</th>
                  <th className="p-3 font-semibold text-gray-600">Items</th>
                  <th className="p-3 font-semibold text-gray-600">Total</th>
                  <th className="p-3 font-semibold text-gray-600">Date</th>
                </tr>
              </thead>
              <tbody>
                {orders.length === 0 ? (
                  <tr><td colSpan={6} className="p-8 text-center text-gray-400">No orders yet</td></tr>
                ) : orders.map(o => (
                  <tr key={o.id} className="border-t border-gray-50 hover:bg-blue-50/30">
                    <td className="p-3 font-medium text-gray-800">{o.id}</td>
                    <td className="p-3">
                      <span className={`text-xs font-semibold px-2 py-0.5 rounded-full capitalize ${
                        o.status === 'delivered' ? 'bg-green-100 text-green-700' :
                        o.status === 'shipped' ? 'bg-blue-100 text-blue-700' :
                        o.status === 'confirmed' ? 'bg-purple-100 text-purple-700' :
                        o.status === 'cancelled' ? 'bg-red-100 text-red-700' :
                        'bg-orange-100 text-orange-700'
                      }`}>{o.status}</span>
                    </td>
                    <td className="p-3 text-xs text-gray-500">{o.paymentMethod}</td>
                    <td className="p-3 text-gray-500">{o.items.length}</td>
                    <td className="p-3 font-semibold">₹{o.grandTotal}</td>
                    <td className="p-3 text-xs text-gray-400">{new Date(o.createdAt).toLocaleDateString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ─── Cancelled Orders ─── */}
      {activeTab === 'cancelled' && (
        <div className="space-y-6">
          <div className="grid grid-cols-3 gap-4">
            {[
              { label: 'Total Cancelled', value: salesSummary.cancelledOrders, color: 'from-red-500 to-red-600' },
              { label: 'Cancellation Rate', value: `${salesSummary.totalOrders ? ((salesSummary.cancelledOrders / salesSummary.totalOrders) * 100).toFixed(1) : 0}%`, color: 'from-orange-500 to-orange-600' },
              { label: 'Revenue Lost', value: `₹${cancelledOrders.reduce((s, o) => s + o.grandTotal, 0).toLocaleString()}`, color: 'from-rose-500 to-rose-600' },
            ].map(c => (
              <div key={c.label} className={`bg-gradient-to-br ${c.color} rounded-2xl p-4 text-white`}>
                <p className="text-2xl font-bold">{c.value}</p>
                <p className="text-xs text-white/70 mt-1">{c.label}</p>
              </div>
            ))}
          </div>

          <div className="card-3d overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 text-left">
                  <th className="p-3 font-semibold text-gray-600">Order ID</th>
                  <th className="p-3 font-semibold text-gray-600">Customer</th>
                  <th className="p-3 font-semibold text-gray-600">Items</th>
                  <th className="p-3 font-semibold text-gray-600">Amount Lost</th>
                  <th className="p-3 font-semibold text-gray-600">Payment</th>
                  <th className="p-3 font-semibold text-gray-600">Date</th>
                </tr>
              </thead>
              <tbody>
                {cancelledOrders.length === 0 ? (
                  <tr><td colSpan={6} className="p-8 text-center text-gray-400">No cancelled orders</td></tr>
                ) : cancelledOrders.map(o => (
                  <tr key={o.id} className="border-t border-gray-50 hover:bg-red-50/30">
                    <td className="p-3 font-medium text-gray-800">{o.id}</td>
                    <td className="p-3">
                      <p className="text-gray-800">{o.email}</p>
                      <p className="text-xs text-gray-400">{o.phone}</p>
                    </td>
                    <td className="p-3 text-gray-500">{o.items.length}</td>
                    <td className="p-3 font-semibold text-red-500">₹{o.grandTotal}</td>
                    <td className="p-3 text-xs text-gray-500">{o.paymentMethod}</td>
                    <td className="p-3 text-xs text-gray-400">{new Date(o.createdAt).toLocaleDateString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ─── Most Sold Items ─── */}
      {activeTab === 'top' && (
        <div className="card-3d overflow-hidden">
          <div className="p-4 border-b border-gray-100">
            <h2 className="font-bold text-gray-800">Most Sold Items</h2>
            <p className="text-xs text-gray-400 mt-1">Top selling products by quantity sold</p>
          </div>
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50 text-left">
                <th className="p-3 font-semibold text-gray-600">#</th>
                <th className="p-3 font-semibold text-gray-600">Product</th>
                <th className="p-3 font-semibold text-gray-600">Category</th>
                <th className="p-3 font-semibold text-gray-600">Total Qty Sold</th>
                <th className="p-3 font-semibold text-gray-600">Total Revenue</th>
              </tr>
            </thead>
            <tbody>
              {topProducts.length === 0 ? (
                <tr><td colSpan={5} className="p-8 text-center text-gray-400">No sales data yet</td></tr>
              ) : topProducts.sort((a, b) => b.totalQty - a.totalQty).slice(0, 20).map((p, i) => (
                <tr key={p.productId} className="border-t border-gray-50 hover:bg-blue-50/30">
                  <td className="p-3 text-gray-400 font-medium">{i + 1}</td>
                  <td className="p-3 font-medium text-gray-800">{p.name}</td>
                  <td className="p-3 text-xs text-gray-500 capitalize">{p.category.replace(/-/g, ' ')}</td>
                  <td className="p-3">
                    <div className="flex items-center gap-2">
                      <div className="flex-1 bg-gray-100 rounded-full h-2 max-w-[120px]">
                        <div className="h-full rounded-full bg-emerald-400" style={{ width: `${Math.min(100, (p.totalQty / Math.max(...topProducts.map(x => x.totalQty))) * 100)}%` }} />
                      </div>
                      <span className="font-semibold text-gray-800">{p.totalQty}</span>
                    </div>
                  </td>
                  <td className="p-3 font-semibold text-green-600">₹{p.totalRevenue.toLocaleString()}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* ─── Least Sold Items ─── */}
      {activeTab === 'bottom' && (
        <div className="card-3d overflow-hidden">
          <div className="p-4 border-b border-gray-100">
            <h2 className="font-bold text-gray-800">Least Sold / Unsold Items</h2>
            <p className="text-xs text-gray-400 mt-1">Products with lowest sales — includes unsold items (0 qty)</p>
          </div>
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-gray-50 text-left">
                <th className="p-3 font-semibold text-gray-600">#</th>
                <th className="p-3 font-semibold text-gray-600">Product</th>
                <th className="p-3 font-semibold text-gray-600">Category</th>
                <th className="p-3 font-semibold text-gray-600">Total Qty Sold</th>
                <th className="p-3 font-semibold text-gray-600">Status</th>
              </tr>
            </thead>
            <tbody>
              {bottomProducts.length === 0 ? (
                <tr><td colSpan={5} className="p-8 text-center text-gray-400">No data</td></tr>
              ) : bottomProducts.map((p, i) => (
                <tr key={p.productId} className={`border-t border-gray-50 hover:bg-red-50/30 ${p.totalQty === 0 ? 'bg-red-50/40' : ''}`}>
                  <td className="p-3 text-gray-400 font-medium">{i + 1}</td>
                  <td className="p-3 font-medium text-gray-800">{p.name}</td>
                  <td className="p-3 text-xs text-gray-500 capitalize">{p.category.replace(/-/g, ' ')}</td>
                  <td className="p-3 font-semibold text-gray-800">{p.totalQty}</td>
                  <td className="p-3">
                    {p.totalQty === 0 ? (
                      <span className="text-xs font-semibold px-2 py-0.5 rounded-full bg-red-100 text-red-600">Unsold</span>
                    ) : (
                      <span className="text-xs font-semibold px-2 py-0.5 rounded-full bg-orange-100 text-orange-600">Low</span>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* ─── User Report ─── */}
      {activeTab === 'users' && (
        <div className="space-y-6">
          <div className="grid grid-cols-4 gap-4">
            {[
              { label: 'Total Users', value: userReport.total, color: 'from-blue-500 to-blue-600' },
              { label: 'Regular Users', value: userReport.regular, color: 'from-green-500 to-green-600' },
              { label: 'Users with Orders', value: userReport.withOrders, color: 'from-purple-500 to-purple-600' },
              { label: 'Total Spent (All)', value: `₹${userReport.totalSpent.toLocaleString()}`, color: 'from-emerald-500 to-emerald-600' },
            ].map(c => (
              <div key={c.label} className={`bg-gradient-to-br ${c.color} rounded-2xl p-4 text-white`}>
                <p className="text-2xl font-bold">{c.value}</p>
                <p className="text-xs text-white/70 mt-1">{c.label}</p>
              </div>
            ))}
          </div>

          <div className="card-3d p-5">
            <h2 className="font-bold text-gray-800 mb-4">User Registration Overview</h2>
            <div className="flex items-center gap-6 flex-wrap">
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-blue-500" />
                <span className="text-sm text-gray-600">Admins: <strong>{userReport.admins}</strong></span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-green-500" />
                <span className="text-sm text-gray-600">Regular Users: <strong>{userReport.regular}</strong></span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-purple-500" />
                <span className="text-sm text-gray-600">Active (placed orders): <strong>{userReport.withOrders}</strong></span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-orange-500" />
                <span className="text-sm text-gray-600">Inactive: <strong>{userReport.regular - userReport.withOrders}</strong></span>
              </div>
            </div>
          </div>

          <div className="card-3d overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 text-left">
                  <th className="p-3 font-semibold text-gray-600">User</th>
                  <th className="p-3 font-semibold text-gray-600">Email</th>
                  <th className="p-3 font-semibold text-gray-600">Role</th>
                  <th className="p-3 font-semibold text-gray-600">Orders</th>
                  <th className="p-3 font-semibold text-gray-600">Joined</th>
                </tr>
              </thead>
              <tbody>
                {users.map(u => (
                  <tr key={u.id} className="border-t border-gray-50 hover:bg-blue-50/30">
                    <td className="p-3">
                      <div className="flex items-center gap-2">
                        <div className="w-7 h-7 rounded-full bg-[#0C52AF] text-white text-xs flex items-center justify-center font-bold">
                          {u.name.split(' ').map(n => n[0]).join('').slice(0, 2)}
                        </div>
                        <span className="font-medium text-gray-800">{u.name}</span>
                      </div>
                    </td>
                    <td className="p-3 text-xs text-gray-500">{u.email}</td>
                    <td className="p-3">
                      <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${u.role === 'admin' ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'}`}>
                        {u.role}
                      </span>
                    </td>
                    <td className="p-3 text-gray-600">{u.orders}</td>
                    <td className="p-3 text-xs text-gray-400">{u.createdAt}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ─── LMS Report ─── */}
      {activeTab === 'lms' && (
        <div className="space-y-6">
          <div className="grid grid-cols-3 gap-4">
            {[
              { label: 'Total Certificates Downloaded', value: lmsReport.reduce((s, r) => s + r.certificatesDownloaded, 0), color: 'from-blue-500 to-blue-600' },
              { label: 'Total Subscriptions Created', value: lmsReport.reduce((s, r) => s + r.subscriptionsCreated, 0), color: 'from-green-500 to-green-600' },
              { label: 'Conversion Rate', value: `${lmsReport.length ? Math.round((lmsReport.reduce((s, r) => s + r.subscriptionsCreated, 0) / Math.max(1, lmsReport.reduce((s, r) => s + r.certificatesDownloaded, 0))) * 100) : 0}%`, color: 'from-purple-500 to-purple-600' },
            ].map(c => (
              <div key={c.label} className={`bg-gradient-to-br ${c.color} rounded-2xl p-4 text-white`}>
                <p className="text-2xl font-bold">{c.value}</p>
                <p className="text-xs text-white/70 mt-1">{c.label}</p>
              </div>
            ))}
          </div>

          <div className="card-3d overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 text-left">
                  <th className="p-3 font-semibold text-gray-600">Course</th>
                  <th className="p-3 font-semibold text-gray-600">Certificates Downloaded</th>
                  <th className="p-3 font-semibold text-gray-600">Subscriptions Created</th>
                  <th className="p-3 font-semibold text-gray-600">Conversion</th>
                  <th className="p-3 font-semibold text-gray-600">Month</th>
                </tr>
              </thead>
              <tbody>
                {lmsReport.length === 0 ? (
                  <tr><td colSpan={5} className="p-8 text-center text-gray-400">No LMS data yet</td></tr>
                ) : lmsReport.map(r => (
                  <tr key={r.id} className="border-t border-gray-50 hover:bg-blue-50/30">
                    <td className="p-3 font-medium text-gray-800">{r.courseName}</td>
                    <td className="p-3">{r.certificatesDownloaded}</td>
                    <td className="p-3">{r.subscriptionsCreated}</td>
                    <td className="p-3">
                      <span className="text-xs font-semibold px-2 py-0.5 rounded-full bg-green-100 text-green-700">
                        {r.certificatesDownloaded ? Math.round((r.subscriptionsCreated / r.certificatesDownloaded) * 100) : 0}%
                      </span>
                    </td>
                    <td className="p-3 text-xs text-gray-400">{r.month}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ─── Offers Redeemed ─── */}
      {activeTab === 'offers' && (
        <div className="space-y-6">
          <div className="grid grid-cols-3 gap-4">
            {[
              { label: 'Total Offers Redeemed', value: offersReport.reduce((s, r) => s + r.redeemedCount, 0), color: 'from-pink-500 to-pink-600' },
              { label: 'Revenue from Offers', value: `₹${offersReport.reduce((s, r) => s + r.revenueImpact, 0).toLocaleString()}`, color: 'from-emerald-500 to-emerald-600' },
              { label: 'Avg Revenue per Offer', value: `₹${offersReport.length ? Math.round(offersReport.reduce((s, r) => s + r.revenueImpact, 0) / offersReport.length) : 0}`, color: 'from-orange-500 to-orange-600' },
            ].map(c => (
              <div key={c.label} className={`bg-gradient-to-br ${c.color} rounded-2xl p-4 text-white`}>
                <p className="text-2xl font-bold">{c.value}</p>
                <p className="text-xs text-white/70 mt-1">{c.label}</p>
              </div>
            ))}
          </div>

          <div className="card-3d overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 text-left">
                  <th className="p-3 font-semibold text-gray-600">Offer</th>
                  <th className="p-3 font-semibold text-gray-600">Times Redeemed</th>
                  <th className="p-3 font-semibold text-gray-600">Revenue Impact</th>
                  <th className="p-3 font-semibold text-gray-600">Avg per Redemption</th>
                  <th className="p-3 font-semibold text-gray-600">Month</th>
                </tr>
              </thead>
              <tbody>
                {offersReport.length === 0 ? (
                  <tr><td colSpan={5} className="p-8 text-center text-gray-400">No offer redemption data yet</td></tr>
                ) : offersReport.map(o => (
                  <tr key={o.id} className="border-t border-gray-50 hover:bg-pink-50/30">
                    <td className="p-3 font-medium text-gray-800">{o.offerName}</td>
                    <td className="p-3 font-semibold">{o.redeemedCount}</td>
                    <td className="p-3 font-semibold text-green-600">₹{o.revenueImpact.toLocaleString()}</td>
                    <td className="p-3 text-gray-600">₹{o.redeemedCount ? Math.round(o.revenueImpact / o.redeemedCount) : 0}</td>
                    <td className="p-3 text-xs text-gray-400">{o.month}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  )
}
