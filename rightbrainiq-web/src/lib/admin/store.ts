'use client'

import { useState, useEffect, useCallback } from 'react'

const STORAGE_KEYS = {
  products: 'rb_admin_products',
  categories: 'rb_admin_categories',
  orders: 'rb_admin_orders',
  sliders: 'rb_admin_sliders',
  users: 'rb_admin_users',
  invoices: 'rb_admin_invoices',
  banners: 'rb_admin_banners',
  salesReport: 'rb_admin_sales_report',
  lmsReport: 'rb_admin_lms_report',
  offersReport: 'rb_admin_offers_report',
} as const

function load<T>(key: string, fallback: T): T {
  if (typeof window === 'undefined') return fallback
  try {
    const raw = localStorage.getItem(key)
    return raw ? JSON.parse(raw) : fallback
  } catch { return fallback }
}

function save(key: string, data: unknown) {
  if (typeof window !== 'undefined') localStorage.setItem(key, JSON.stringify(data))
}

// ─── Types ───
export type AdminProduct = {
  id: string; name: string; slug: string; category_slug: string; price: number; currency: string
  image_url: string; image_url2: string | null; card_count: number; description: string; color: string
  stock: number; createdAt: string
}

export type AdminCategory = {
  id: number; name: string; slug: string; product_count: number; image_url: string; description: string
}

export type AdminOrder = {
  id: string; items: { productId: string; name: string; qty: number; price: number }[]
  total: number; deliveryFee: number; grandTotal: number
  address: string; city: string; pincode: string; phone: string; email: string
  paymentMethod: string; status: 'pending' | 'confirmed' | 'shipped' | 'delivered' | 'cancelled'
  createdAt: string; notes: string
}

export type AdminSlider = {
  id: string; image: string; title: string; subtitle: string; link: string; order: number; active: boolean
}

export type AdminUser = {
  id: string; name: string; email: string; phone: string; role: 'admin' | 'user'; orders: number; createdAt: string
}

export type AdminInvoice = {
  id: string; orderId: string; customer: string; items: number; total: number; status: 'paid' | 'pending' | 'overdue'
  dueDate: string; createdAt: string
}

export type AdminBanner = {
  id: string; image: string; title: string; link: string; position: string; active: boolean
}

export type MonthlySales = {
  month: string; revenue: number; orders: number; cancelled: number; itemsSold: number
}

export type TopProduct = {
  productId: string; name: string; category: string; totalQty: number; totalRevenue: number
}

export type LmsReportEntry = {
  id: string; courseName: string; certificatesDownloaded: number; subscriptionsCreated: number; month: string
}

export type OfferRedeemed = {
  id: string; offerName: string; redeemedCount: number; revenueImpact: number; month: string
}

// ─── Store Hook ───
export function useAdminStore() {
  const [products, setProducts] = useState<AdminProduct[]>([])
  const [categories, setCategories] = useState<AdminCategory[]>([])
  const [orders, setOrders] = useState<AdminOrder[]>([])
  const [sliders, setSliders] = useState<AdminSlider[]>([])
  const [users, setUsers] = useState<AdminUser[]>([])
  const [invoices, setInvoices] = useState<AdminInvoice[]>([])
  const [banners, setBanners] = useState<AdminBanner[]>([])
  const [salesReport, setSalesReport] = useState<MonthlySales[]>([])
  const [lmsReport, setLmsReport] = useState<LmsReportEntry[]>([])
  const [offersReport, setOffersReport] = useState<OfferRedeemed[]>([])
  const [ready, setReady] = useState(false)

  useEffect(() => {
    setProducts(load(STORAGE_KEYS.products, getDefaultProducts()))
    setCategories(load(STORAGE_KEYS.categories, getDefaultCategories()))
    setOrders(load(STORAGE_KEYS.orders, getDefaultOrders()))
    setSliders(load(STORAGE_KEYS.sliders, getDefaultSliders()))
    setUsers(load(STORAGE_KEYS.users, getDefaultUsers()))
    setInvoices(load(STORAGE_KEYS.invoices, getDefaultInvoices()))
    setBanners(load(STORAGE_KEYS.banners, getDefaultBanners()))
    setSalesReport(load(STORAGE_KEYS.salesReport, getDefaultSalesReport()))
    setLmsReport(load(STORAGE_KEYS.lmsReport, getDefaultLmsReport()))
    setOffersReport(load(STORAGE_KEYS.offersReport, getDefaultOffersReport()))
    setReady(true)
  }, [])

  const persist = useCallback((key: string, data: unknown) => save(key, data), [])

  const updateProducts = useCallback((v: AdminProduct[] | ((p: AdminProduct[]) => AdminProduct[])) => {
    setProducts(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.products, next); return next })
  }, [persist])
  const updateCategories = useCallback((v: AdminCategory[] | ((p: AdminCategory[]) => AdminCategory[])) => {
    setCategories(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.categories, next); return next })
  }, [persist])
  const updateOrders = useCallback((v: AdminOrder[] | ((p: AdminOrder[]) => AdminOrder[])) => {
    setOrders(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.orders, next); return next })
  }, [persist])
  const updateSliders = useCallback((v: AdminSlider[] | ((p: AdminSlider[]) => AdminSlider[])) => {
    setSliders(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.sliders, next); return next })
  }, [persist])
  const updateUsers = useCallback((v: AdminUser[] | ((p: AdminUser[]) => AdminUser[])) => {
    setUsers(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.users, next); return next })
  }, [persist])
  const updateInvoices = useCallback((v: AdminInvoice[] | ((p: AdminInvoice[]) => AdminInvoice[])) => {
    setInvoices(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.invoices, next); return next })
  }, [persist])
  const updateBanners = useCallback((v: AdminBanner[] | ((p: AdminBanner[]) => AdminBanner[])) => {
    setBanners(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.banners, next); return next })
  }, [persist])
  const updateSalesReport = useCallback((v: MonthlySales[] | ((p: MonthlySales[]) => MonthlySales[])) => {
    setSalesReport(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.salesReport, next); return next })
  }, [persist])
  const updateLmsReport = useCallback((v: LmsReportEntry[] | ((p: LmsReportEntry[]) => LmsReportEntry[])) => {
    setLmsReport(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.lmsReport, next); return next })
  }, [persist])
  const updateOffersReport = useCallback((v: OfferRedeemed[] | ((p: OfferRedeemed[]) => OfferRedeemed[])) => {
    setOffersReport(prev => { const next = typeof v === 'function' ? v(prev) : v; persist(STORAGE_KEYS.offersReport, next); return next })
  }, [persist])

  const stats = {
    totalProducts: products.length,
    totalOrders: orders.length,
    pendingOrders: orders.filter(o => o.status === 'pending').length,
    totalUsers: users.filter(u => u.role === 'user').length,
    revenue: orders.filter(o => o.status !== 'cancelled').reduce((s, o) => s + o.grandTotal, 0),
    activeSliders: sliders.filter(s => s.active).length,
  }

  const topProducts: TopProduct[] = (() => {
    const map = new Map<string, { name: string; category: string; totalQty: number; totalRevenue: number }>()
    for (const o of orders) {
      if (o.status === 'cancelled') continue
      for (const item of o.items) {
        const p = products.find(x => x.id === item.productId)
        const existing = map.get(item.productId)
        if (existing) {
          existing.totalQty += item.qty
          existing.totalRevenue += item.price * item.qty
        } else {
          map.set(item.productId, {
            name: item.name,
            category: p?.category_slug ?? '',
            totalQty: item.qty,
            totalRevenue: item.price * item.qty,
          })
        }
      }
    }
    return Array.from(map.entries()).map(([productId, v]) => ({ productId, ...v }))
  })()

  const salesSummary = (() => {
    const completed = orders.filter(o => o.status !== 'cancelled')
    const cancelled = orders.filter(o => o.status === 'cancelled')
    return {
      totalRevenue: completed.reduce((s, o) => s + o.grandTotal, 0),
      totalOrders: orders.length,
      completedOrders: completed.length,
      cancelledOrders: cancelled.length,
      totalItemsSold: completed.reduce((s, o) => s + o.items.reduce((a, i) => a + i.qty, 0), 0),
    }
  })()

  return { ready, products, categories, orders, sliders, users, invoices, banners, stats, salesReport, lmsReport, offersReport, topProducts, salesSummary, updateProducts, updateCategories, updateOrders, updateSliders, updateUsers, updateInvoices, updateBanners, updateSalesReport, updateLmsReport, updateOffersReport }
}

// ─── Default Seed Data ───
function getDefaultProducts(): AdminProduct[] {
  const baseUrl = 'https://rightbrainiq.com/wp-content/uploads'
  return [
    { id: 'ss-1', name: 'FLAGS', slug: 'flags', category_slug: 'smart-start-cards', price: 340, currency: '₹', image_url: `${baseUrl}/2025/08/FLAGS-600x600.jpg`, image_url2: `${baseUrl}/2025/09/flag-1-600x600.jpg`, card_count: 20, description: 'World flags recognition cards', color: 'red', stock: 50, createdAt: '2025-08-01' },
    { id: 'ss-2', name: 'ANIMALS', slug: 'animals', category_slug: 'smart-start-cards', price: 340, currency: '₹', image_url: `${baseUrl}/2025/08/ANIMALS-600x600.jpg`, image_url2: `${baseUrl}/2025/09/ANIMALS-1-600x600.jpg`, card_count: 20, description: 'Wild and domestic animals', color: 'orange', stock: 50, createdAt: '2025-08-01' },
    { id: 'ss-3', name: 'FRUITS', slug: 'fruits', category_slug: 'smart-start-cards', price: 340, currency: '₹', image_url: `${baseUrl}/2025/08/FRUITS-600x600.jpg`, image_url2: `${baseUrl}/2025/08/FRUITS-1-600x600.webp`, card_count: 20, description: 'Fruit names and recognition', color: 'yellow', stock: 50, createdAt: '2025-08-01' },
    { id: 'ss-4', name: 'VEGETABLES', slug: 'vegetables', category_slug: 'smart-start-cards', price: 340, currency: '₹', image_url: `${baseUrl}/2025/08/VEGETABLES-600x600.jpg`, image_url2: `${baseUrl}/2025/08/VEGETABLES-1-600x600.webp`, card_count: 20, description: 'Vegetable names and recognition', color: 'green', stock: 50, createdAt: '2025-08-01' },
    { id: 'jb-1', name: 'Animals Jumbo', slug: 'animals-jumbo', category_slug: 'jumbo-pack', price: 1568, currency: '₹', image_url: `${baseUrl}/2025/08/ANIMALS-600x600.jpg`, image_url2: null, card_count: 101, description: 'Jumbo sized animal cards — 101 cards', color: 'green', stock: 20, createdAt: '2025-08-01' },
    { id: 'cc-1', name: 'Connect Cards 1', slug: 'connect-cards-1', category_slug: 'connect-cards', price: 1568, currency: '₹', image_url: `${baseUrl}/2025/10/Connect-Cards-1-1-600x600.webp`, image_url2: null, card_count: 30, description: 'Associative learning set 1', color: 'purple', stock: 30, createdAt: '2025-10-01' },
    { id: 'geo-1', name: 'AIRPORT', slug: 'airport', category_slug: 'geo-cards', price: 340, currency: '₹', image_url: `${baseUrl}/2025/09/AIRPORT-GEO-CARD-600x600.webp`, image_url2: null, card_count: 20, description: 'Learn about airports', color: 'blue', stock: 50, createdAt: '2025-09-01' },
    { id: 'mg-1', name: 'AFGHANISTAN', slug: 'afghanistan', category_slug: 'mini-globe-cards', price: 340, currency: '₹', image_url: `${baseUrl}/2025/09/AFGHANISTAN-Card-600x600.webp`, image_url2: null, card_count: 20, description: 'Learn about Afghanistan', color: 'red', stock: 40, createdAt: '2025-09-01' },
    { id: 'hc-1', name: 'High Contrast Set-1', slug: 'high-contrast-set-1', category_slug: 'high-contrast', price: 340, currency: '₹', image_url: `${baseUrl}/2025/10/High-Contrest-1-1-600x600.jpg`, image_url2: null, card_count: 20, description: 'Infant visual stimulation set 1', color: 'red', stock: 60, createdAt: '2025-10-01' },
  ]
}

function getDefaultCategories(): AdminCategory[] {
  return [
    { id: 1, name: 'SMART START CARDS', slug: 'smart-start-cards', product_count: 100, image_url: 'https://rightbrainiq.com/wp-content/uploads/2025/11/SMART-START-CARDS-600x600.jpg', description: 'Foundation learning cards for early brain development' },
    { id: 2, name: 'CONNECT CARDS', slug: 'connect-cards', product_count: 6, image_url: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-CARDS-600x600.jpg', description: 'Associative learning cards for pattern recognition' },
    { id: 3, name: 'GEO CARDS', slug: 'geo-cards', product_count: 50, image_url: 'https://rightbrainiq.com/wp-content/uploads/2025/10/GEO-card-Front-image-600x600.webp', description: 'Geography cards exploring places around the world' },
    { id: 4, name: 'MINI GLOBE CARDS', slug: 'mini-globe-cards', product_count: 50, image_url: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Mini-globe-cards-Front-Image-600x600.webp', description: 'Country cards for global awareness' },
    { id: 5, name: 'JUMBO CARDS', slug: 'jumbo-pack', product_count: 10, image_url: 'https://rightbrainiq.com/wp-content/uploads/2025/10/JUMBO-CARDS-1-600x600.jpg', description: 'Large format flash cards for immersive learning' },
    { id: 6, name: 'HIGH CONTRAST', slug: 'high-contrast', product_count: 6, image_url: 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Con-1-600x600.jpg', description: 'High contrast cards for infant visual stimulation' },
  ]
}

function getDefaultOrders(): AdminOrder[] {
  return [
    { id: 'ORD-1001', items: [{ productId: 'ss-1', name: 'FLAGS', qty: 2, price: 340 }, { productId: 'ss-2', name: 'ANIMALS', qty: 1, price: 340 }], total: 1020, deliveryFee: 49, grandTotal: 1069, address: '123 Main St', city: 'Chennai', pincode: '600001', phone: '+91 98765 43210', email: 'customer@example.com', paymentMethod: 'COD', status: 'pending', createdAt: '2026-06-08T10:30:00Z', notes: '' },
    { id: 'ORD-1002', items: [{ productId: 'jb-1', name: 'Animals Jumbo', qty: 1, price: 1568 }], total: 1568, deliveryFee: 0, grandTotal: 1568, address: '456 Park Ave', city: 'Mumbai', pincode: '400001', phone: '+91 98765 43211', email: 'parent2@example.com', paymentMethod: 'UPI', status: 'shipped', createdAt: '2026-06-07T14:00:00Z', notes: 'Handle with care' },
    { id: 'ORD-1003', items: [{ productId: 'hc-1', name: 'High Contrast Set-1', qty: 3, price: 340 }], total: 1020, deliveryFee: 0, grandTotal: 1020, address: '789 Lake View', city: 'Bangalore', pincode: '560001', phone: '+91 98765 43212', email: 'parent3@example.com', paymentMethod: 'Card', status: 'delivered', createdAt: '2026-06-05T09:00:00Z', notes: '' },
    { id: 'ORD-1004', items: [{ productId: 'ss-3', name: 'FRUITS', qty: 1, price: 340 }], total: 340, deliveryFee: 0, grandTotal: 340, address: '321 River Rd', city: 'Delhi', pincode: '110001', phone: '+91 98765 43213', email: 'parent4@example.com', paymentMethod: 'COD', status: 'confirmed', createdAt: '2026-06-09T08:00:00Z', notes: '' },
  ]
}

function getDefaultSliders(): AdminSlider[] {
  return [
    { id: 'sld-1', image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.4-1.webp', title: 'Big knowledge in small cards', subtitle: 'Scientifically designed flashcards for early brain development', link: '/products', order: 1, active: true },
    { id: 'sld-2', image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.2-1.webp', title: 'Smart Start Cards', subtitle: 'Foundation learning — 15 topics available', link: '/products?category=smart-start-cards', order: 2, active: true },
    { id: 'sld-3', image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.1.webp', title: 'Jumbo Cards', subtitle: 'Large format — 101 cards per set', link: '/products?category=jumbo-pack', order: 3, active: true },
    { id: 'sld-4', image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.3-1.webp', title: 'Connect Cards', subtitle: 'Associative learning for pattern recognition', link: '/products?category=connect-cards', order: 4, active: true },
  ]
}

function getDefaultUsers(): AdminUser[] {
  return [
    { id: 'usr-1', name: 'Admin User', email: 'admin@rightbrainiq.com', phone: '+91 96293 86639', role: 'admin', orders: 0, createdAt: '2025-01-01' },
    { id: 'usr-2', name: 'Rajesh Kumar', email: 'rajesh@example.com', phone: '+91 98765 43210', role: 'user', orders: 3, createdAt: '2026-01-15' },
    { id: 'usr-3', name: 'Priya Sharma', email: 'priya@example.com', phone: '+91 98765 43211', role: 'user', orders: 1, createdAt: '2026-03-20' },
    { id: 'usr-4', name: 'Amit Singh', email: 'amit@example.com', phone: '+91 98765 43212', role: 'user', orders: 2, createdAt: '2026-04-10' },
  ]
}

function getDefaultInvoices(): AdminInvoice[] {
  return [
    { id: 'INV-1001', orderId: 'ORD-1001', customer: 'Rajesh Kumar', items: 2, total: 1069, status: 'pending', dueDate: '2026-06-15', createdAt: '2026-06-08' },
    { id: 'INV-1002', orderId: 'ORD-1002', customer: 'Priya Sharma', items: 1, total: 1568, status: 'paid', dueDate: '2026-06-14', createdAt: '2026-06-07' },
    { id: 'INV-1003', orderId: 'ORD-1003', customer: 'Amit Singh', items: 1, total: 1020, status: 'paid', dueDate: '2026-06-12', createdAt: '2026-06-05' },
    { id: 'INV-1004', orderId: 'ORD-1004', customer: 'Rajesh Kumar', items: 1, total: 340, status: 'pending', dueDate: '2026-06-16', createdAt: '2026-06-09' },
  ]
}

function getDefaultSalesReport(): MonthlySales[] {
  return [
    { month: '2026-01', revenue: 45200, orders: 28, cancelled: 2, itemsSold: 85 },
    { month: '2026-02', revenue: 38900, orders: 24, cancelled: 1, itemsSold: 72 },
    { month: '2026-03', revenue: 52300, orders: 32, cancelled: 3, itemsSold: 98 },
    { month: '2026-04', revenue: 61800, orders: 38, cancelled: 2, itemsSold: 115 },
    { month: '2026-05', revenue: 49500, orders: 30, cancelled: 4, itemsSold: 91 },
    { month: '2026-06', revenue: 34100, orders: 22, cancelled: 2, itemsSold: 67 },
  ]
}

function getDefaultLmsReport(): LmsReportEntry[] {
  return [
    { id: 'lms-1', courseName: 'RightBrainIQ Method', certificatesDownloaded: 45, subscriptionsCreated: 28, month: '2026-06' },
    { id: 'lms-2', courseName: 'Flash Card Mastery', certificatesDownloaded: 32, subscriptionsCreated: 19, month: '2026-06' },
    { id: 'lms-3', courseName: 'Memory Techniques', certificatesDownloaded: 27, subscriptionsCreated: 15, month: '2026-06' },
    { id: 'lms-4', courseName: 'Speed Reading', certificatesDownloaded: 18, subscriptionsCreated: 11, month: '2026-06' },
    { id: 'lms-5', courseName: 'Language Development', certificatesDownloaded: 38, subscriptionsCreated: 22, month: '2026-06' },
    { id: 'lms-6', courseName: 'Math Foundations', certificatesDownloaded: 24, subscriptionsCreated: 16, month: '2026-06' },
  ]
}

function getDefaultOffersReport(): OfferRedeemed[] {
  return [
    { id: 'off-1', offerName: 'Summer Sale - 20% Off', redeemedCount: 48, revenueImpact: 12400, month: '2026-06' },
    { id: 'off-2', offerName: 'Buy 2 Get 1 Free', redeemedCount: 32, revenueImpact: 8900, month: '2026-06' },
    { id: 'off-3', offerName: 'New User Discount - 15%', redeemedCount: 56, revenueImpact: 10200, month: '2026-06' },
    { id: 'off-4', offerName: 'LMS Bundle Offer', redeemedCount: 22, revenueImpact: 15800, month: '2026-06' },
    { id: 'off-5', offerName: 'Free Shipping Weekend', redeemedCount: 74, revenueImpact: 5600, month: '2026-06' },
  ]
}

function getDefaultBanners(): AdminBanner[] {
  return [
    { id: 'bnr-1', image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/JUMBO-CARDS-1-600x600.jpg', title: 'Premium Jumbo Cards', link: '/products?category=jumbo-pack', position: 'home-top', active: true },
    { id: 'bnr-2', image: 'https://rightbrainiq.com/wp-content/uploads/2025/11/SMART-START-CARDS-600x600.jpg', title: 'Smart Start Sale', link: '/products?category=smart-start-cards', position: 'home-middle', active: true },
  ]
}
