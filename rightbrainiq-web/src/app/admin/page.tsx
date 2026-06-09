'use client'

import { useAdminStore } from '@/lib/admin/store'
import Link from 'next/link'

export default function AdminDashboard() {
  const { stats, orders, products, users, sliders } = useAdminStore()

  const cards = [
    { label: 'Total Products', value: stats.totalProducts, icon: '📦', color: 'from-blue-500 to-blue-600', link: '/admin/products' },
    { label: 'Total Orders', value: stats.totalOrders, icon: '🛵', color: 'from-purple-500 to-purple-600', link: '/admin/orders' },
    { label: 'Pending Orders', value: stats.pendingOrders, icon: '⏳', color: 'from-orange-500 to-orange-600', link: '/admin/orders' },
    { label: 'Registered Users', value: stats.totalUsers, icon: '👥', color: 'from-green-500 to-green-600', link: '/admin/users' },
    { label: 'Revenue', value: `₹${stats.revenue.toLocaleString()}`, icon: '💰', color: 'from-emerald-500 to-emerald-600', link: '/admin/invoices' },
    { label: 'Active Sliders', value: stats.activeSliders, icon: '🎠', color: 'from-pink-500 to-pink-600', link: '/admin/sliders' },
  ]

  const recentOrders = orders.slice(0, 5)
  const lowStock = products.filter(p => p.stock < 25).slice(0, 5)

  return (
    <div>
      <h1 className="text-2xl font-bold text-[#0A2061] mb-6">Dashboard</h1>

      {/* Stats Grid */}
      <div className="grid grid-cols-2 lg:grid-cols-3 xl:grid-cols-6 gap-4 mb-8">
        {cards.map(c => (
          <Link key={c.label} href={c.link} className="block">
            <div className={`bg-gradient-to-br ${c.color} rounded-2xl p-4 text-white hover:shadow-lg hover:-translate-y-1 transition-all`}>
              <span className="text-2xl">{c.icon}</span>
              <p className="text-2xl font-bold mt-2">{c.value}</p>
              <p className="text-xs text-white/70 mt-1">{c.label}</p>
            </div>
          </Link>
        ))}
      </div>

      <div className="grid lg:grid-cols-2 gap-6">
        {/* Recent Orders */}
        <div className="card-3d p-5">
          <div className="flex items-center justify-between mb-4">
            <h2 className="font-bold text-gray-800">Recent Orders</h2>
            <Link href="/admin/orders" className="text-xs text-[#0C52AF] hover:underline">View All</Link>
          </div>
          <div className="space-y-3">
            {recentOrders.length === 0 ? (
              <p className="text-sm text-gray-400 text-center py-8">No orders yet</p>
            ) : recentOrders.map(o => (
              <div key={o.id} className="flex items-center justify-between py-2 border-b border-gray-50 last:border-0">
                <div>
                  <p className="text-sm font-medium text-gray-800">{o.id}</p>
                  <p className="text-xs text-gray-400">{o.items.length} item(s) · {new Date(o.createdAt).toLocaleDateString()}</p>
                </div>
                <div className="text-right">
                  <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${
                    o.status === 'delivered' ? 'bg-green-100 text-green-700' :
                    o.status === 'shipped' ? 'bg-blue-100 text-blue-700' :
                    o.status === 'confirmed' ? 'bg-purple-100 text-purple-700' :
                    o.status === 'cancelled' ? 'bg-red-100 text-red-700' :
                    'bg-orange-100 text-orange-700'
                  }`}>{o.status}</span>
                  <p className="text-xs text-gray-500 mt-1">₹{o.grandTotal}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Low Stock Alerts */}
        <div className="card-3d p-5">
          <div className="flex items-center justify-between mb-4">
            <h2 className="font-bold text-gray-800">Low Stock Alerts</h2>
            <Link href="/admin/products" className="text-xs text-[#0C52AF] hover:underline">Manage</Link>
          </div>
          <div className="space-y-3">
            {lowStock.length === 0 ? (
              <p className="text-sm text-green-600 text-center py-8">✅ All products have sufficient stock</p>
            ) : lowStock.map(p => (
              <div key={p.id} className="flex items-center justify-between py-2 border-b border-gray-50 last:border-0">
                <div className="flex items-center gap-3">
                  <img src={p.image_url} alt={p.name} className="w-10 h-10 rounded-lg object-cover" />
                  <div>
                    <p className="text-sm font-medium text-gray-800">{p.name}</p>
                    <p className="text-xs text-gray-400">{p.category_slug}</p>
                  </div>
                </div>
                <span className={`text-sm font-bold ${p.stock < 10 ? 'text-red-500' : 'text-orange-500'}`}>{p.stock}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
