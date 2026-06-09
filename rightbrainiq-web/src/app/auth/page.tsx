'use client'

import { useState } from 'react'

export default function AuthPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [isSignUp, setIsSignUp] = useState(false)
  const [message, setMessage] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setMessage('')
    // Supabase auth integration will go here
    setMessage(`${isSignUp ? 'Account created' : 'Signed in'} successfully! (Demo)`)
  }

  return (
    <div className="min-h-[60vh] flex items-center justify-center px-4">
      <div className="w-full max-w-sm">
        <h1 className="text-2xl font-bold text-[#0A2061] mb-6 text-center">
          {isSignUp ? 'Create Account' : 'Sign In'}
        </h1>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input type="email" placeholder="Email" value={email}
            onChange={e => setEmail(e.target.value)} required
            className="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" />
          <input type="password" placeholder="Password" value={password}
            onChange={e => setPassword(e.target.value)} required
            className="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:border-[#0C52AF]" />
          <button type="submit" className="w-full bg-[#0C52AF] text-white py-3 rounded-xl font-bold hover:bg-[#0A2061] transition">
            {isSignUp ? 'Sign Up' : 'Sign In'}
          </button>
        </form>
        {message && <p className="text-center text-sm text-[#49933F] mt-4">{message}</p>}
        <p className="text-center text-sm text-gray-500 mt-6">
          {isSignUp ? 'Already have an account?' : "Don't have an account?"}{' '}
          <button onClick={() => setIsSignUp(!isSignUp)} className="text-[#0C52AF] font-medium hover:underline">
            {isSignUp ? 'Sign In' : 'Sign Up'}
          </button>
        </p>
      </div>
    </div>
  )
}
