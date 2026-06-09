'use client'

import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { useState } from 'react'
import { useAdminStore } from '@/lib/admin/store'

const navItems = [
  { label: 'Dashboard', href: '/admin', icon: '📊' },
  { label: 'Products', href: '/admin/products', icon: '📦' },
  { label: 'Categories', href: '/admin/categories', icon: '🏷️' },
  { label: 'Orders', href: '/admin/orders', icon: '🛵' },
  { label: 'Reports', href: '/admin/reports', icon: '📈' },
  { label: 'Sliders', href: '/admin/sliders', icon: '🎠' },
  { label: 'Banners', href: '/admin/banners', icon: '🖼️' },
  { label: 'Users', href: '/admin/users', icon: '👥' },
  { label: 'Invoices', href: '/admin/invoices', icon: '📄' },
]

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname()
  const router = useRouter()
  const { stats } = useAdminStore()
  const [collapsed, setCollapsed] = useState(false)

  return (
    <div className="flex min-h-screen bg-gray-50">
      {/* Sidebar */}
      <aside className={`fixed left-0 top-0 bottom-0 z-40 bg-[#0A2061] text-white transition-all duration-300 flex flex-col ${collapsed ? 'w-16' : 'w-60'}`}>
        <div className="flex items-center justify-between p-4 border-b border-blue-800/30">
          {!collapsed && (
            <Link href="/admin" className="font-bold text-sm">RightBrain<span className="text-[#FCA10C]">IQ</span> Admin</Link>
          )}
          <button onClick={() => setCollapsed(!collapsed)} className="p-1.5 rounded-lg hover:bg-blue-800/50 transition">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
          </button>
        </div>
        <nav className="flex-1 overflow-y-auto p-2 space-y-1">
          {navItems.map(item => {
            const active = pathname === item.href || (item.href !== '/admin' && pathname.startsWith(item.href))
            return (
              <Link key={item.href} href={item.href}
                className={`flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm transition ${
                  active ? 'bg-white/15 text-white font-semibold' : 'text-blue-200/70 hover:bg-white/10 hover:text-white'
                }`}
                title={item.label}
              >
                <span className="text-lg flex-shrink-0">{item.icon}</span>
                {!collapsed && <span>{item.label}</span>}
              </Link>
            )
          })}
        </nav>
        <div className="p-4 border-t border-blue-800/30">
          <Link href="/" className="flex items-center gap-2 text-xs text-blue-300/70 hover:text-white transition">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
            {!collapsed && 'Back to Site'}
          </Link>
        </div>
      </aside>

      {/* Main */}
      <div className={`flex-1 transition-all duration-300 ${collapsed ? 'ml-16' : 'ml-60'}`}>
        {/* Top bar */}
        <header className="sticky top-0 z-30 bg-white/95 backdrop-blur-md border-b border-gray-100 h-16 flex items-center justify-between px-6">
          <div>
            <p className="text-sm text-gray-500">Welcome back, Admin</p>
          </div>
          <div className="flex items-center gap-3">
            <span className="text-xs text-gray-400 bg-gray-100 px-2.5 py-1 rounded-full">
              {stats.totalProducts} products · {stats.pendingOrders} pending
            </span>
            <button onClick={() => router.push('/')} className="p-2 text-gray-400 hover:text-[#0C52AF] rounded-lg hover:bg-blue-50 transition">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
            </button>
          </div>
        </header>
        <main className="p-6">{children}</main>
      </div>
    </div>
  )
}
