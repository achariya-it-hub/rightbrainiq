import Link from 'next/link'

export default function AboutPage() {
  return (
    <div>
      {/* Hero */}
      <section className="bg-gradient-to-br from-[#0A2061] via-[#0C52AF] to-[#3496D3] text-white py-20">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <span className="text-xs font-semibold text-[#FCA10C] bg-white/10 px-4 py-1.5 rounded-full uppercase tracking-wider">About Us</span>
          <h1 className="text-4xl md:text-5xl font-extrabold mt-6 mb-4">Building and boosting the Brain better using Flash Cards</h1>
          <p className="text-blue-100/80 max-w-2xl mx-auto">A Unit of Miway Teaching Aids Pvt. Ltd. — Pondicherry, India</p>
        </div>
      </section>

      {/* Mission */}
      <section className="py-16 md:py-24">
        <div className="max-w-5xl mx-auto px-4 grid md:grid-cols-2 gap-10 items-center">
          <div>
            <h2 className="text-3xl font-extrabold text-[#0A2061] mb-4">Our Mission</h2>
            <div className="w-16 h-1 bg-[#0C52AF] mb-6 rounded-full" />
            <p className="text-gray-600 leading-relaxed mb-4">
              At Right Brain IQ, we believe every child has extraordinary potential waiting to be unlocked. Our mission is to provide parents and educators with the most effective tools for early childhood development.
            </p>
            <p className="text-gray-500 leading-relaxed mb-4">
              Each flashcard is thoughtfully designed by child development experts to stimulate the right hemisphere of the brain — boosting creativity, memory power, problem-solving, and emotional intelligence during the critical early years (ages 0-8).
            </p>
            <p className="text-gray-500 leading-relaxed">
              We go beyond traditional learning with scientifically designed tools, flashcards, puzzles, and brain games that activate the right brain, helping children learn faster, think smarter, and grow more confident, all while having fun.
            </p>
          </div>
          <div className="relative">
            <div className="rounded-2xl overflow-hidden shadow-xl">
              <img src="https://rightbrainiq.com/wp-content/uploads/2025/08/ChatGPT-Image-Aug-12-2025-02_02_36-AM-1-1024x683.png" alt="RightBrainIQ" className="w-full h-auto" />
            </div>
          </div>
        </div>
      </section>

      {/* Stats */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-5xl mx-auto px-4 grid grid-cols-2 md:grid-cols-4 gap-6">
          {[
            { num: '200+', label: 'Topics Covered' },
            { num: '50K+', label: 'Happy Parents' },
            { num: '0-8', label: 'Age Range' },
            { num: '🇮🇳', label: 'Made in India' },
          ].map((s, i) => (
            <div key={i} className="card-3d p-6 text-center">
              <p className="text-3xl font-extrabold text-[#0C52AF]">{s.num}</p>
              <p className="text-sm text-gray-500 mt-1">{s.label}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Story */}
      <section className="py-16 md:py-24">
        <div className="max-w-5xl mx-auto px-4 grid md:grid-cols-2 gap-10 items-center">
          <div className="relative md:order-2">
            <div className="rounded-2xl overflow-hidden shadow-xl">
              <img src="https://rightbrainiq.com/wp-content/uploads/2025/08/slider2-1024x683.png" alt="Kids learning" className="w-full h-auto" />
            </div>
          </div>
          <div className="md:order-1">
            <h2 className="text-3xl font-extrabold text-[#0A2061] mb-4">Every card Sharpens Smartness</h2>
            <div className="w-16 h-1 bg-[#FCA10C] mb-6 rounded-full" />
            <p className="text-gray-600 leading-relaxed mb-4">
              Educational flash cards are more than just colorful pieces of paper — they are a proven method for early brain stimulation. Our scientifically designed tools activate the right brain, enhancing creativity, memory, problem-solving, and emotional intelligence.
            </p>
            <p className="text-gray-500 leading-relaxed mb-4">
              Founded in Pondicherry, India, RightBrainIQ is a unit of Miway Teaching Aids Pvt. Ltd., committed to making quality education accessible to every child through innovative learning tools.
            </p>
            <Link href="/products" className="btn-primary inline-block text-sm px-6 py-3">
              Explore Our Products →
            </Link>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 bg-gradient-to-br from-[#0A2061] to-[#0C52AF] text-white text-center">
        <div className="max-w-2xl mx-auto px-4">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-3">Start the first step Today...</h2>
          <p className="text-[#FCA10C] font-semibold mb-6">Where Learning Meets Unlimited Potential</p>
          <Link href="/contact" className="btn-accent text-base px-8 py-3.5 inline-block">
            Contact Us Today
          </Link>
        </div>
      </section>
    </div>
  )
}
