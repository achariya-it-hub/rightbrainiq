'use client'

import Link from 'next/link'
import { useState, useEffect } from 'react'
import { useSupabase } from '@/lib/supabase/provider'
import ProductCard from '@/components/product-card'

const heroSlides = [
  {
    image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.4-1.webp',
    gradient: 'from-[#0A2061]/90 via-[#0C52AF]/80 to-transparent',
  },
  {
    image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.2-1.webp',
    gradient: 'from-[#0A2061]/90 via-[#A52883]/80 to-transparent',
  },
  {
    image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.1.webp',
    gradient: 'from-[#0A2061]/90 via-[#49933F]/70 to-transparent',
  },
  {
    image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.3-1.webp',
    gradient: 'from-[#0A2061]/90 via-[#FCA10C]/70 to-transparent',
  },
  {
    image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.5-1.webp',
    gradient: 'from-[#0A2061]/90 via-[#FC641E]/70 to-transparent',
  },
  {
    image: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Artboard-1.6-1.webp',
    gradient: 'from-[#0A2061]/90 via-[#EC2E4F]/70 to-transparent',
  },
]

const categories = [
  { name: 'SMART START CARDS', slug: 'smart-start-cards', img: 'https://rightbrainiq.com/wp-content/uploads/2025/11/SMART-START-CARDS-600x600.jpg' },
  { name: 'CONNECT CARDS', slug: 'connect-cards', img: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-CARDS-600x600.jpg' },
  { name: 'GEO CARDS', slug: 'geo-cards', img: 'https://rightbrainiq.com/wp-content/uploads/2025/10/GEO-card-Front-image-600x600.webp' },
  { name: 'MINI GLOBE CARDS', slug: 'mini-globe-cards', img: 'https://rightbrainiq.com/wp-content/uploads/2025/10/Mini-globe-cards-Front-Image-600x600.webp' },
  { name: 'JUMBO CARDS', slug: 'jumbo-pack', img: 'https://rightbrainiq.com/wp-content/uploads/2025/10/JUMBO-CARDS-1-600x600.jpg' },
  { name: 'HIGH CONTRAST', slug: 'high-contrast', img: 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Con-1-600x600.jpg' },
]

const benefits = [
  { icon: '🧠', title: 'Boost Memory Power', desc: 'Quick visual recall strengthens brain connections.' },
  { icon: '🎯', title: 'Enhance Focus & Attention', desc: 'Improves concentration through short, engaging activities.' },
  { icon: '📖', title: 'Develop Vocabulary & Skills', desc: 'Learn words, concepts, and ideas faster.' },
  { icon: '✨', title: 'Stimulate Creativity', desc: 'Encourages imaginative thinking and mental flexibility.' },
]

const testimonials = [
  { quote: 'These flash cards have been a game changer for my 3-year-old! She now recognizes animals, shapes, and colors much faster than before. Learning feels like playtime. Highly recommended for every parent.', name: 'Kamal', location: 'Bangalore' },
  { quote: 'As a teacher, I\'ve tried many learning tools, but these flash cards stand out. The bright colors and clear illustrations keep my students engaged, and I\'ve seen remarkable improvements in their memory skills.', name: 'Jessica', location: 'Teacher' },
  { quote: 'The flash cards are not only visually appealing but also thoughtfully designed to support right-brain development. They\'ve been an excellent addition to our Montessori classroom resources.', name: 'Nicolas Anelka', location: 'Educator' },
]

export default function HomePage() {
  const { products, loading } = useSupabase()
  const [heroIdx, setHeroIdx] = useState(0)
  const [testiIdx, setTestiIdx] = useState(0)

  useEffect(() => {
    const t = setInterval(() => setHeroIdx(p => (p + 1) % heroSlides.length), 4000)
    return () => clearInterval(t)
  }, [])

  useEffect(() => {
    const t = setInterval(() => setTestiIdx(p => (p + 1) % testimonials.length), 5000)
    return () => clearInterval(t)
  }, [])

  const featured = products.filter(p => ['ss-1','ss-2','ss-3','ss-5','ss-8','ss-14','ss-9','jb-1'].some(id => p.id === id))

  return (
    <div>
      {/* ===== HERO SLIDER ===== */}
      <section className="relative h-[70vh] min-h-[500px] max-h-[700px] overflow-hidden">
        {heroSlides.map((s, i) => (
          <div key={i} className={`absolute inset-0 transition-opacity duration-700 ${i === heroIdx ? 'opacity-100' : 'opacity-0'}`}>
            <img src={s.image} alt="" className="absolute inset-0 w-full h-full object-cover" />
            <div className={`absolute inset-0 bg-gradient-to-r ${s.gradient}`} />
          </div>
        ))}
        <div className="absolute inset-0 flex items-center">
          <div className="max-w-7xl mx-auto px-4 w-full">
            <div className="max-w-xl relative z-10">
              <span className="inline-block px-4 py-1.5 rounded-full bg-white/15 text-white/90 text-xs font-semibold mb-4 backdrop-blur-sm border border-white/20">
                Every card Sharpens Smartness
              </span>
              <h1 className="text-4xl md:text-6xl lg:text-7xl font-extrabold text-white leading-tight mb-4">
                Big knowledge<br />in <span className="text-[#FCA10C]">small cards</span>
              </h1>
              <p className="text-lg md:text-xl text-white/80 mb-8 max-w-lg">
                Scientifically designed flashcards for early brain development — ages 0-8
              </p>
              <div className="flex items-center gap-4">
                <Link href="/products" className="btn-accent text-base px-8 py-3.5 inline-block shadow-lg shadow-[#FCA10C]/30">
                  Shop Now
                </Link>
                <Link href="/lms" className="text-white/80 hover:text-white font-medium text-sm flex items-center gap-2 transition bg-white/10 backdrop-blur-sm px-5 py-3 rounded-full">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                  Watch Demo
                </Link>
              </div>
            </div>
          </div>
        </div>
        {/* Dots */}
        <div className="absolute bottom-6 left-1/2 -translate-x-1/2 flex gap-2 z-20">
          {heroSlides.map((_, i) => (
            <button key={i} onClick={() => setHeroIdx(i)}
              className={`w-2.5 h-2.5 rounded-full transition-all ${i === heroIdx ? 'bg-white w-8' : 'bg-white/40 hover:bg-white/60'}`} />
          ))}
        </div>
      </section>

      {/* ===== WHY FLASH CARDS ===== */}
      <section className="py-16 md:py-24 bg-white">
        <div className="max-w-6xl mx-auto px-4 text-center">
          <span className="text-xs font-semibold text-[#0C52AF] bg-blue-50 px-4 py-1.5 rounded-full uppercase tracking-wider">Why Flash Cards</span>
          <h2 className="text-3xl md:text-5xl font-extrabold text-[#0A2061] mt-4 mb-4">
            Every card <span className="text-[#FCA10C]">Sharpens Smartness</span>
          </h2>
          <div className="w-20 h-1 bg-[#0C52AF] mx-auto mb-6 rounded-full" />
          <p className="text-gray-600 max-w-3xl mx-auto leading-relaxed text-base md:text-lg">
            Educational flash cards are more than just colorful pieces of paper — they are a proven method for early brain stimulation.
          </p>
          <p className="text-gray-500 max-w-3xl mx-auto leading-relaxed mt-4 text-sm md:text-base">
            At Right Brain IQ, we go beyond traditional learning with scientifically designed tools, flashcards, puzzles, and brain games that activate the right brain — enhancing creativity, memory, problem-solving, and emotional intelligence. We help children learn faster, think smarter, and grow more confident, all while having fun.
          </p>
          <div className="mt-8 grid grid-cols-2 md:grid-cols-4 gap-4 max-w-3xl mx-auto">
            {[
              { stat: '200+', label: 'Topics Covered' },
              { stat: '50K+', label: 'Happy Parents' },
              { stat: '0-8', label: 'Age Range' },
              { stat: '🇮🇳', label: 'Made in India' },
            ].map((s, i) => (
              <div key={i} className="card-3d p-4">
                <p className="text-2xl font-extrabold text-[#0C52AF]">{s.stat}</p>
                <p className="text-xs text-gray-500 mt-1">{s.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ===== ABOUT US ===== */}
      <section className="py-16 md:py-24 bg-gradient-to-br from-gray-50 to-blue-50/50">
        <div className="max-w-6xl mx-auto px-4 grid md:grid-cols-2 gap-10 items-center">
          <div className="relative">
            <div className="rounded-2xl overflow-hidden shadow-xl">
              <img src="https://rightbrainiq.com/wp-content/uploads/2025/10/Flash-Card.jpg" alt="Flash cards for kids" className="w-full h-auto" />
            </div>
            <div className="absolute -bottom-4 -right-4 w-28 h-28 bg-[#FCA10C] rounded-2xl -z-10 hidden md:block" />
            <div className="absolute -top-4 -left-4 w-20 h-20 bg-[#0C52AF] rounded-2xl -z-10 hidden md:block" />
          </div>
          <div>
            <span className="text-xs font-semibold text-[#A52883] bg-purple-50 px-4 py-1.5 rounded-full uppercase tracking-wider">About Us</span>
            <h2 className="text-3xl md:text-4xl font-extrabold text-[#0A2061] mt-4 mb-4">
              Building and boosting the Brain better using Flash Cards
            </h2>
            <div className="w-16 h-1 bg-[#0C52AF] mb-6 rounded-full" />
            <p className="text-gray-600 leading-relaxed mb-4">
              At Right Brain IQ, we believe every child has extraordinary potential waiting to be unlocked. Our mission is to provide parents and educators with the most effective tools for early childhood development.
            </p>
            <p className="text-gray-500 leading-relaxed mb-4">
              Each flashcard is thoughtfully designed by child development experts to stimulate the right hemisphere of the brain — boosting creativity, memory power, problem-solving, and emotional intelligence during the critical early years (ages 0-8).
            </p>
            <p className="text-gray-500 leading-relaxed">
              A Unit of Miway Teaching Aids Pvt. Ltd., Pondicherry — committed to making quality education accessible to every child.
            </p>
            <Link href="/products" className="btn-primary mt-6 inline-block text-sm px-6 py-3">
              Explore Our Products →
            </Link>
          </div>
        </div>
      </section>

      {/* ===== FEATURED PRODUCTS ===== */}
      {!loading && featured.length > 0 && (
        <section className="py-16 md:py-24 bg-white">
          <div className="max-w-7xl mx-auto px-4">
            <div className="text-center mb-10">
              <span className="text-xs font-semibold text-[#0C52AF] bg-blue-50 px-4 py-1.5 rounded-full uppercase tracking-wider">Latest</span>
              <h2 className="text-3xl md:text-4xl font-extrabold text-[#0A2061] mt-4">Flash Cards On Fire!</h2>
              <div className="w-16 h-1 bg-[#FCA10C] mx-auto mt-4 rounded-full" />
            </div>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              {featured.map((p, i) => <ProductCard key={p.id} product={p} index={i} />)}
            </div>
          </div>
        </section>
      )}

      {/* ===== CATEGORIES ===== */}
      <section className="py-16 bg-gradient-to-br from-gray-50 to-blue-50/50">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center mb-10">
            <h2 className="text-3xl md:text-4xl font-extrabold text-[#0A2061]">Browse by Category</h2>
            <p className="text-gray-500 mt-2">Find the perfect set for your child&apos;s learning journey</p>
          </div>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {categories.map((cat, i) => (
              <Link key={cat.slug} href={`/products?category=${cat.slug}`}
                className="card-3d p-4 text-center group animate-fade-in-up" style={{ animationDelay: `${i * 80}ms` }}>
                <div className="w-full aspect-square rounded-xl overflow-hidden mb-3 bg-gray-50">
                  <img src={cat.img} alt={cat.name} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                </div>
                <h3 className="font-bold text-xs text-gray-800 leading-tight group-hover:text-[#0C52AF] transition-colors">{cat.name}</h3>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ===== BENEFITS ===== */}
      <section className="py-16 md:py-24 bg-white">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-extrabold text-[#0A2061]">Why Parents Love Us</h2>
            <div className="w-16 h-1 bg-[#0C52AF] mx-auto mt-4 rounded-full" />
          </div>
          <div className="grid md:grid-cols-4 gap-6">
            {benefits.map((b, i) => (
              <div key={i} className="card-3d p-6 text-center animate-fade-in-up" style={{ animationDelay: `${i * 100}ms` }}>
                <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-[#0C52AF]/10 to-[#3496D3]/10 flex items-center justify-center mx-auto mb-4 text-3xl">
                  {b.icon}
                </div>
                <h3 className="font-bold text-gray-800 mb-2">{b.title}</h3>
                <p className="text-sm text-gray-500 leading-relaxed">{b.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ===== TESTIMONIALS ===== */}
      <section className="py-16 md:py-24 bg-gradient-to-br from-[#0A2061] to-[#0C52AF] text-white">
        <div className="max-w-3xl mx-auto px-4 text-center">
          <span className="text-xs font-semibold text-[#FCA10C] bg-white/10 px-4 py-1.5 rounded-full uppercase tracking-wider">Testimonials</span>
          <h2 className="text-3xl md:text-4xl font-extrabold mt-4 mb-10">What Parents Say</h2>
          <div className="relative min-h-[200px]">
            {testimonials.map((t, i) => (
              <div key={i} className={`transition-all duration-500 absolute inset-0 flex flex-col items-center justify-center ${i === testiIdx ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4 pointer-events-none'}`}>
                <svg className="w-10 h-10 text-[#FCA10C]/40 mb-4" fill="currentColor" viewBox="0 0 24 24"><path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z"/></svg>
                <p className="text-lg md:text-xl leading-relaxed italic mb-6 max-w-xl text-white/90">&ldquo;{t.quote}&rdquo;</p>
                <p className="font-bold text-[#FCA10C]">{t.name}</p>
                <p className="text-sm text-white/60">{t.location}</p>
              </div>
            ))}
          </div>
          <div className="flex justify-center gap-2 mt-4">
            {testimonials.map((_, i) => (
              <button key={i} onClick={() => setTestiIdx(i)}
                className={`w-2 h-2 rounded-full transition-all ${i === testiIdx ? 'bg-[#FCA10C] w-6' : 'bg-white/30 hover:bg-white/50'}`} />
            ))}
          </div>
        </div>
      </section>

      {/* ===== CTA ===== */}
      <section className="py-16 md:py-24 bg-white text-center relative overflow-hidden">
        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#0C52AF] via-[#FCA10C] to-[#A52883]" />
        <div className="max-w-2xl mx-auto px-4">
          <h2 className="text-3xl md:text-5xl font-extrabold text-[#0A2061] mb-3">
            Start the first step Today...
          </h2>
          <p className="text-xl text-[#FCA10C] font-semibold mb-2">Where Learning Meets Unlimited Potential</p>
          <p className="text-gray-500 mb-8">Join thousands of parents who have chosen RightBrainIQ for their child&apos;s development.</p>
          <Link href="/products" className="btn-primary text-lg px-10 py-4 inline-block shadow-lg shadow-[#0C52AF]/20">
            Shop All Cards →
          </Link>
          <p className="text-xs text-gray-400 mt-4">A Unit of Miway Teaching Aids Pvt. Ltd. | Pondicherry, India</p>
        </div>
      </section>
    </div>
  )
}
