'use client'

import { useState } from 'react'
import Link from 'next/link'
import { useToast } from '@/components/toast'

export default function ContactPage() {
  const { showToast } = useToast()
  const [form, setForm] = useState({ name: '', email: '', phone: '', message: '' })
  const [sending, setSending] = useState(false)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!form.name || !form.email || !form.message) {
      showToast('Please fill in all required fields', 'error')
      return
    }
    setSending(true)
    await new Promise(r => setTimeout(r, 1500))
    showToast('Message sent! We\'ll get back to you soon.')
    setForm({ name: '', email: '', phone: '', message: '' })
    setSending(false)
  }

  return (
    <div>
      {/* Hero */}
      <section className="bg-gradient-to-br from-[#0A2061] via-[#0C52AF] to-[#3496D3] text-white py-20">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <span className="text-xs font-semibold text-[#FCA10C] bg-white/10 px-4 py-1.5 rounded-full uppercase tracking-wider">Get in Touch</span>
          <h1 className="text-4xl md:text-5xl font-extrabold mt-6 mb-4">Contact Us</h1>
          <p className="text-blue-100/80 max-w-xl mx-auto">Have a question? We&apos;d love to hear from you. Send us a message and we&apos;ll respond as soon as possible.</p>
        </div>
      </section>

      <section className="py-16 md:py-24">
        <div className="max-w-5xl mx-auto px-4 grid md:grid-cols-2 gap-12">
          {/* Contact Info */}
          <div>
            <h2 className="text-2xl font-extrabold text-[#0A2061] mb-6">Get in Touch</h2>
            <div className="w-16 h-1 bg-[#0C52AF] mb-8 rounded-full" />

            <div className="space-y-6">
              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#0C52AF" strokeWidth="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                </div>
                <div>
                  <p className="font-semibold text-gray-800">Address</p>
                  <p className="text-sm text-gray-500">A Unit of Miway Teaching Aids Pvt. Ltd.<br />Pondicherry, India</p>
                </div>
              </div>

              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#0C52AF" strokeWidth="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                </div>
                <div>
                  <p className="font-semibold text-gray-800">Email</p>
                  <a href="mailto:info@rightbrainiq.com" className="text-sm text-[#0C52AF] hover:underline">info@rightbrainiq.com</a>
                </div>
              </div>

              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#0C52AF" strokeWidth="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                </div>
                <div>
                  <p className="font-semibold text-gray-800">Phone</p>
                  <a href="tel:+919629386639" className="text-sm text-[#0C52AF] hover:underline">+91 96293 86639</a><br />
                  <a href="tel:+919344451222" className="text-sm text-[#0C52AF] hover:underline">+91 93444 51222</a>
                </div>
              </div>

              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#0C52AF" strokeWidth="2"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
                </div>
                <div>
                  <p className="font-semibold text-gray-800">WhatsApp</p>
                  <a href="https://wa.me/919629386639" target="_blank" rel="noopener noreferrer" className="text-sm text-[#0C52AF] hover:underline">+91 96293 86639</a>
                </div>
              </div>
            </div>
          </div>

          {/* Form */}
          <div className="card-3d p-8">
            <h2 className="text-2xl font-extrabold text-[#0A2061] mb-6">Send a Message</h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Name *</label>
                <input type="text" value={form.name} onChange={e => setForm(f => ({ ...f, name: e.target.value }))}
                  className="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" placeholder="Your name" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                <input type="email" value={form.email} onChange={e => setForm(f => ({ ...f, email: e.target.value }))}
                  className="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" placeholder="your@email.com" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                <input type="tel" value={form.phone} onChange={e => setForm(f => ({ ...f, phone: e.target.value }))}
                  className="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" placeholder="+91 XXXXX XXXXX" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Message *</label>
                <textarea value={form.message} onChange={e => setForm(f => ({ ...f, message: e.target.value }))}
                  className="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF] resize-none h-32" placeholder="How can we help?" />
              </div>
              <button type="submit" disabled={sending}
                className="btn-primary w-full py-3.5 text-base disabled:opacity-60 disabled:cursor-not-allowed flex items-center justify-center gap-2">
                {sending ? (
                  <><svg className="animate-spin h-5 w-5" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none"/><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/></svg>Sending...</>
                ) : 'Send Message'}
              </button>
            </form>
          </div>
        </div>
      </section>

      {/* FAQ Link */}
      <section className="py-16 bg-gray-50 text-center">
        <div className="max-w-xl mx-auto px-4">
          <h2 className="text-2xl font-bold text-[#0A2061] mb-3">Frequently Asked Questions</h2>
          <p className="text-gray-500 mb-6">Find quick answers to common questions about our products, shipping, and returns.</p>
          <Link href="/faq" className="btn-primary text-sm px-6 py-3 inline-block">View FAQ</Link>
        </div>
      </section>
    </div>
  )
}
