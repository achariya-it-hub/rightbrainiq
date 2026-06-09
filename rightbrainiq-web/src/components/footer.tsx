import Link from 'next/link'

export default function Footer() {
  return (
    <footer className="bg-[#0A2061] text-white pt-16 pb-8 mt-20">
      <div className="max-w-7xl mx-auto px-4">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-12">
          {/* Brand */}
          <div>
            <Link href="/" className="inline-block mb-3">
              <img src="/logo.png" alt="RightBrainIQ" className="h-12 w-auto brightness-0 invert" />
            </Link>
            <p className="text-sm text-blue-200/70 leading-relaxed max-w-xs">
              Smart flash cards designed by early childhood experts for brain development.
            </p>
          </div>

          {/* Shop */}
          <div>
            <h4 className="font-bold text-sm mb-4 text-blue-200">Shop</h4>
            <div className="space-y-2">
              <Link href="/products?category=smart-start-cards" className="block text-sm text-blue-200/70 hover:text-white transition">Smart Start Cards</Link>
              <Link href="/products?category=connect-cards" className="block text-sm text-blue-200/70 hover:text-white transition">Connect Cards</Link>
              <Link href="/products?category=geo-cards" className="block text-sm text-blue-200/70 hover:text-white transition">Geo Cards</Link>
              <Link href="/products?category=mini-globe-cards" className="block text-sm text-blue-200/70 hover:text-white transition">Mini Globe Cards</Link>
              <Link href="/products?category=jumbo-pack" className="block text-sm text-blue-200/70 hover:text-white transition">Jumbo Cards</Link>
              <Link href="/products?category=high-contrast" className="block text-sm text-blue-200/70 hover:text-white transition">High Contrast</Link>
            </div>
          </div>

          {/* Learn */}
          <div>
            <h4 className="font-bold text-sm mb-4 text-blue-200">Company</h4>
            <div className="space-y-2">
              <Link href="/about" className="block text-sm text-blue-200/70 hover:text-white transition">About Us</Link>
              <Link href="/contact" className="block text-sm text-blue-200/70 hover:text-white transition">Contact Us</Link>
              <Link href="/lms" className="block text-sm text-blue-200/70 hover:text-white transition">All Courses</Link>
              <Link href="/cart" className="block text-sm text-blue-200/70 hover:text-white transition">Cart</Link>
              <Link href="/auth" className="block text-sm text-blue-200/70 hover:text-white transition">My Account</Link>
            </div>
          </div>

          {/* Support */}
          <div>
            <h4 className="font-bold text-sm mb-4 text-blue-200">Support</h4>
            <div className="space-y-2">
              <p className="text-sm text-blue-200/70">Email: support@rightbrainiq.com</p>
              <p className="text-sm text-blue-200/70">Phone: +91-XXXXXXXXXX</p>
            </div>
          </div>
        </div>

        <div className="border-t border-blue-800/50 pt-6 text-center text-sm text-blue-300/60">
          <p>© 2026 RightBrainIQ. All rights reserved.</p>
        </div>
      </div>
    </footer>
  )
}
