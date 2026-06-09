import Link from 'next/link'

const faqs = [
  { q: 'What age group are these cards for?', a: 'Our flashcards are designed for children ages 0-8 years. Each product page specifies the recommended age range for that specific set.' },
  { q: 'How many cards per pack?', a: 'Smart Start, GEO, Mini Globe & High Contrast packs contain ~20 cards each. Connect Cards have 30 cards per set. Jumbo Cards contain 101 cards per set.' },
  { q: 'What is your return policy?', a: 'We offer a 7-day return policy. If you are not satisfied with your purchase, contact us within 7 days of delivery for a full refund or exchange. Items must be unused and in original packaging.' },
  { q: 'Do you offer shipping?', a: 'Yes, we ship across India. Free shipping on orders above ₹999. Standard delivery takes 3-7 business days depending on your location.' },
  { q: 'What payment methods do you accept?', a: 'We accept Cash on Delivery (COD), UPI (Google Pay, PhonePe, Paytm), and Credit/Debit Cards (Visa, Mastercard, RuPay).' },
  { q: 'Are the cards safe for babies?', a: 'Absolutely! All our cards are made with child-safe, non-toxic materials with rounded corners. The High Contrast series is specifically designed for infant visual stimulation from birth.' },
  { q: 'Do you have a learning app?', a: 'Yes! Our interactive LMS (Learning Management System) is built into the website. Visit the Learn section to access courses, digital flashcards, and track your child\'s progress.' },
  { q: 'What is Right Brain education?', a: 'Right Brain education focuses on stimulating the right hemisphere of the brain — responsible for creativity, memory, intuition, and emotional intelligence. Our flashcards use speed reading, pattern recognition, and visualization techniques to activate these abilities during the critical early years.' },
  { q: 'Can I order in bulk?', a: 'Yes, we offer bulk orders for schools, preschools, and daycare centers. Contact us at info@rightbrainiq.com for special pricing and volume discounts.' },
  { q: 'How are the cards designed?', a: 'Each card is designed by child development experts using right-brain stimulation techniques. They feature vibrant colors, clear imagery, and are made from durable, child-safe materials.' },
  { q: 'Do you ship internationally?', a: 'Currently, we ship across India. For international shipping inquiries, please contact us at info@rightbrainiq.com.' },
  { q: 'Can I track my order?', a: 'Yes, once your order is shipped, you will receive a tracking number via email or SMS to track your delivery status.' },
]

export default function FaqPage() {
  return (
    <div>
      <section className="bg-gradient-to-br from-[#0A2061] via-[#0C52AF] to-[#3496D3] text-white py-20">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <span className="text-xs font-semibold text-[#FCA10C] bg-white/10 px-4 py-1.5 rounded-full uppercase tracking-wider">FAQ</span>
          <h1 className="text-4xl md:text-5xl font-extrabold mt-6 mb-4">Frequently Asked Questions</h1>
          <p className="text-blue-100/80 max-w-xl mx-auto">Everything you need to know about RightBrainIQ flash cards</p>
        </div>
      </section>

      <section className="py-16 md:py-24">
        <div className="max-w-3xl mx-auto px-4 space-y-4">
          {faqs.map((faq, i) => (
            <details key={i} className="card-3d p-5 group open:border-[#0C52AF]/20">
              <summary className="flex items-center justify-between cursor-pointer list-none">
                <h3 className="font-semibold text-gray-800 pr-4">{faq.q}</h3>
                <svg className="w-5 h-5 text-gray-400 flex-shrink-0 group-open:rotate-180 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M19 9l-7 7-7-7" strokeWidth="2"/></svg>
              </summary>
              <p className="mt-4 text-gray-500 text-sm leading-relaxed">{faq.a}</p>
            </details>
          ))}
        </div>
      </section>

      <section className="py-16 bg-gray-50 text-center">
        <div className="max-w-xl mx-auto px-4">
          <h2 className="text-2xl font-bold text-[#0A2061] mb-3">Still have questions?</h2>
          <p className="text-gray-500 mb-6">We&apos;re here to help! Reach out to us anytime.</p>
          <Link href="/contact" className="btn-primary text-sm px-6 py-3 inline-block">Contact Us</Link>
        </div>
      </section>
    </div>
  )
}
