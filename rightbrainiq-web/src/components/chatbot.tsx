'use client'

import { useState, useRef, useEffect } from 'react'
import Link from 'next/link'

type Message = { role: 'bot' | 'user'; text: string }

const faqs: { q: string; a: string }[] = [
  {
    q: 'What age group are these cards for?',
    a: 'Our flashcards are designed for children ages 0-8 years. Each product page specifies the recommended age range.',
  },
  {
    q: 'How many cards per pack?',
    a: 'Smart Start, GEO, Mini Globe & High Contrast packs have ~20 cards. Connect Cards have 30 cards. Jumbo Cards have 101 cards per set.',
  },
  {
    q: 'What is your return policy?',
    a: 'We offer a 7-day return policy. If you\'re not satisfied, contact us within 7 days of delivery for a full refund or exchange.',
  },
  {
    q: 'Do you offer shipping?',
    a: 'Yes! We ship across India. Free shipping on orders above ₹999. Delivery typically takes 3-7 business days.',
  },
  {
    q: 'What payment methods do you accept?',
    a: 'We accept Cash on Delivery (COD), UPI (Google Pay, PhonePe, Paytm), and Credit/Debit Cards (Visa, Mastercard, RuPay).',
  },
  {
    q: 'Are these cards safe for babies?',
    a: 'Absolutely! All our cards are made with child-safe, non-toxic materials with rounded corners. High Contrast cards are specifically designed for infant visual stimulation.',
  },
  {
    q: 'Do you have a learning app?',
    a: 'Yes! Our interactive LMS (Learning Management System) is built into the website. Visit the Learn section to access courses, flashcards, and track progress.',
  },
  {
    q: 'What is Right Brain education?',
    a: 'Right Brain education focuses on stimulating the right hemisphere — responsible for creativity, memory, intuition, and emotional intelligence. Our flashcards use speed reading, pattern recognition, and visualization techniques to activate these abilities.',
  },
  {
    q: 'Can I order in bulk?',
    a: 'Yes, we offer bulk orders for schools, preschools, and daycare centers. Contact us at info@rightbrainiq.com for special pricing.',
  },
  {
    q: 'What makes your cards different?',
    a: 'Our cards are designed by child development experts using right-brain stimulation techniques. Each card features vibrant colors, clear imagery, and is made from durable, child-safe material.',
  },
]

function ChatMessage({ msg }: { msg: Message }) {
  return (
    <div className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'} mb-2`}>
      <div className={`max-w-[85%] rounded-2xl px-4 py-2.5 text-sm leading-relaxed ${
        msg.role === 'user'
          ? 'bg-[#0C52AF] text-white rounded-br-md'
          : 'bg-gray-100 text-gray-700 rounded-bl-md'
      }`}>
        {msg.text}
      </div>
    </div>
  )
}

export default function ChatBot() {
  const [open, setOpen] = useState(false)
  const [messages, setMessages] = useState<Message[]>([
    { role: 'bot', text: '👋 Hi! I\'m the RightBrainIQ assistant. Ask me anything about our flash cards, shipping, or returns!' },
  ])
  const [input, setInput] = useState('')
  const [showFaqs, setShowFaqs] = useState(true)
  const endRef = useRef<HTMLDivElement>(null)
  const inputRef = useRef<HTMLInputElement>(null)

  useEffect(() => { endRef.current?.scrollIntoView({ behavior: 'smooth' }) }, [messages])
  useEffect(() => { if (open) inputRef.current?.focus() }, [open])

  const handleSend = (text: string) => {
    if (!text.trim()) return
    setShowFaqs(false)
    const userMsg: Message = { role: 'user', text: text.trim() }
    setMessages(prev => [...prev, userMsg])
    setInput('')

    const lower = text.toLowerCase()
    const match = faqs.find(f => lower.includes(f.q.toLowerCase().slice(0, 10)))
    const reply: Message = {
      role: 'bot',
      text: match
        ? match.a
        : 'I\'m not sure about that. Try one of the questions above or visit our shop or LMS for more info.',
    }
    setTimeout(() => setMessages(prev => [...prev, reply]), 400)
  }

  return (
    <>
      {/* Bubble */}
      <button
        onClick={() => setOpen(!open)}
        className={`fixed bottom-6 right-6 z-50 w-14 h-14 rounded-full shadow-lg shadow-[#0C52AF]/30 flex items-center justify-center transition-all duration-300 ${
          open ? 'bg-gray-200 rotate-45 scale-90' : 'bg-gradient-to-br from-[#0C52AF] to-[#0A2061] hover:scale-105'
        }`}
      >
        {open ? (
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#333" strokeWidth="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        ) : (
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
          </svg>
        )}
      </button>

      {/* Panel */}
      <div className={`fixed bottom-24 right-6 z-50 w-[360px] max-w-[calc(100vw-2rem)] bg-white rounded-2xl shadow-2xl border border-gray-100 flex flex-col transition-all duration-300 origin-bottom-right ${
        open ? 'opacity-100 scale-100' : 'opacity-0 scale-95 pointer-events-none'
      }`}
        style={{ maxHeight: 'min(600px, calc(100vh - 160px))' }}
      >
        {/* Header */}
        <div className="flex items-center gap-3 p-4 bg-gradient-to-r from-[#0C52AF] to-[#0A2061] text-white rounded-t-2xl">
          <div className="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center text-lg">🤖</div>
          <div className="flex-1">
            <p className="font-semibold text-sm">RightBrainIQ Assistant</p>
            <p className="text-xs text-blue-200">Online — Ask me anything!</p>
          </div>
          <button onClick={() => setMessages([{ role: 'bot', text: '👋 Hi! I\'m the RightBrainIQ assistant. Ask me anything!' }])} className="text-white/60 hover:text-white transition p-1" title="Reset chat">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="23 4 23 10 17 10"/><path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"/></svg>
          </button>
        </div>

        {/* Messages */}
        <div className="flex-1 overflow-y-auto p-4 space-y-1">
          {messages.map((m, i) => <ChatMessage key={i} msg={m} />)}

          {showFaqs && (
            <div className="mt-4">
              <p className="text-xs text-gray-400 mb-2 font-medium">Common questions:</p>
              <div className="space-y-1.5">
                {faqs.slice(0, 5).map((f, i) => (
                  <button key={i} onClick={() => handleSend(f.q)}
                    className="block w-full text-left text-xs text-gray-600 bg-gray-50 hover:bg-gray-100 rounded-xl px-3 py-2 transition">
                    {f.q}
                  </button>
                ))}
              </div>
              <Link href="/products" className="block text-center text-xs text-[#0C52AF] font-medium mt-3 hover:underline">
                Browse all products →
              </Link>
            </div>
          )}
          <div ref={endRef} />
        </div>

        {/* Input */}
        <div className="p-3 border-t border-gray-100">
          <form onSubmit={e => { e.preventDefault(); handleSend(input) }} className="flex gap-2">
            <input ref={inputRef} type="text" value={input} onChange={e => setInput(e.target.value)}
              placeholder="Type your question..."
              className="flex-1 px-4 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF]"
            />
            <button type="submit" disabled={!input.trim()}
              className="w-10 h-10 rounded-xl bg-[#0C52AF] text-white flex items-center justify-center disabled:opacity-40 hover:bg-[#0A2061] transition flex-shrink-0">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
            </button>
          </form>
        </div>
      </div>
    </>
  )
}
