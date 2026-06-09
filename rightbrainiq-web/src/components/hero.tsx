'use client'

import Link from 'next/link'
import { useState, useEffect } from 'react'

const slides = [
  {
    title: 'Ignite Your Child\'s Brain',
    subtitle: 'Research-backed flash cards for ages 0-8',
    cta: 'Shop All Cards',
    link: '/products',
    gradient: 'from-[#0A2061] via-[#0C52AF] to-[#3496D3]',
    image: null,
  },
  {
    title: 'Smart Start Cards',
    subtitle: 'Foundation learning for early brain development — 15 topics',
    cta: 'Explore Smart Start',
    link: '/products?category=smart-start-cards',
    gradient: 'from-[#0C52AF] via-[#3496D3] to-[#0A2061]',
    image: null,
  },
  {
    title: 'Jumbo Cards',
    subtitle: 'Large format flash cards for immersive learning',
    cta: 'Shop Jumbo',
    link: '/products?category=jumbo-pack',
    gradient: 'from-[#A52883] via-[#0C52AF] to-[#0A2061]',
    image: null,
  },
]

export default function HeroCarousel() {
  const [current, setCurrent] = useState(0)

  useEffect(() => {
    const timer = setInterval(() => setCurrent(prev => (prev + 1) % slides.length), 5000)
    return () => clearInterval(timer)
  }, [])

  const slide = slides[current]

  return (
    <section className="relative overflow-hidden">
      {/* Gradient Background */}
      <div className={`bg-gradient-to-br ${slide.gradient} transition-all duration-700`}>
        <div className="max-w-7xl mx-auto px-4 py-20 md:py-28 relative">
          {/* Decorative circles */}
          <div className="absolute top-10 right-10 w-64 h-64 rounded-full bg-white/5 blur-3xl" />
          <div className="absolute bottom-10 left-10 w-48 h-48 rounded-full bg-white/5 blur-2xl" />

          <div className="relative z-10 max-w-2xl">
            <div className="inline-block px-3 py-1 rounded-full bg-white/15 text-white/80 text-xs font-semibold mb-4 backdrop-blur-sm">
              {current === 0 ? 'New Arrivals' : current === 1 ? 'Best Seller' : 'Premium Collection'}
            </div>
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-extrabold text-white leading-tight mb-4">
              {slide.title}
            </h1>
            <p className="text-lg md:text-xl text-blue-100/90 mb-8 max-w-xl">
              {slide.subtitle}
            </p>
            <div className="flex items-center gap-4">
              <Link href={slide.link} className="btn-accent text-base px-8 py-3.5 inline-block">
                {slide.cta}
              </Link>
              <Link href="/lms" className="text-white/80 hover:text-white font-medium text-sm flex items-center gap-2 transition">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                Watch Demo
              </Link>
            </div>
          </div>
        </div>
      </div>

      {/* Dots */}
      <div className="absolute bottom-4 left-1/2 -translate-x-1/2 flex gap-2 z-10">
        {slides.map((_, i) => (
          <button key={i} onClick={() => setCurrent(i)}
            className={`w-2.5 h-2.5 rounded-full transition-all duration-300 ${i === current ? 'bg-white w-8' : 'bg-white/40 hover:bg-white/60'}`} />
        ))}
      </div>
    </section>
  )
}
