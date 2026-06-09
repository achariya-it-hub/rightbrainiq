'use client'

import { useParams } from 'next/navigation'
import Link from 'next/link'
import { getCourse, getLesson, type Flashcard } from '@/lib/lms/data'
import { useState } from 'react'

export default function LessonPlayerPage() {
  const params = useParams()
  const course = getCourse(params.id as string)
  const lesson = getLesson(params.id as string, params.lesson as string)

  const [side, setSide] = useState<'question' | 'answer'>('question')
  const [index, setIndex] = useState(0)
  const [flipped, setFlipped] = useState(false)

  if (!course || !lesson) {
    return (
      <div className="max-w-3xl mx-auto px-4 py-20 text-center">
        <div className="text-7xl mb-6">🔍</div>
        <h1 className="text-3xl font-bold text-gray-800 mb-3">Lesson not found</h1>
        <Link href="/lms" className="btn-primary text-lg inline-block">Back to LMS</Link>
      </div>
    )
  }

  const cards: Flashcard[] = lesson.cards
  const current = cards[index]

  const goTo = (i: number) => {
    setIndex(i)
    setFlipped(false)
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <div className="flex items-center gap-2 text-sm text-gray-400 mb-6">
        <Link href="/" className="hover:text-[#0C52AF]">Home</Link>
        <span>/</span>
        <Link href="/lms" className="hover:text-[#0C52AF]">LMS</Link>
        <span>/</span>
        <Link href={`/lms/${course.id}`} className="hover:text-[#0C52AF] truncate max-w-[120px]">{course.title}</Link>
        <span>/</span>
        <span className="text-gray-700 font-medium truncate max-w-[120px]">{lesson.title}</span>
      </div>

      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-[#0A2061]">{lesson.title}</h1>
          <p className="text-sm text-gray-400">{lesson.cardCount} cards · {lesson.type}</p>
        </div>
        {lesson.videoUrl && (
          <a href={lesson.videoUrl} target="_blank" rel="noopener noreferrer"
            className="flex items-center gap-2 bg-red-50 hover:bg-red-100 text-red-600 rounded-full px-4 py-2 text-sm font-medium transition">
            <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
            Video
          </a>
        )}
      </div>

      {/* Progress */}
      <div className="flex items-center gap-3 mb-6">
        <div className="flex-1 h-2 bg-gray-100 rounded-full overflow-hidden">
          <div className="h-full bg-[#0C52AF] rounded-full transition-all duration-300"
            style={{ width: `${((index + 1) / cards.length) * 100}%` }} />
        </div>
        <span className="text-sm text-gray-500 font-medium whitespace-nowrap">{index + 1}/{cards.length}</span>
      </div>

      {/* Flashcard */}
      <div
        onClick={() => setFlipped(!flipped)}
        className="card-3d p-12 min-h-[320px] flex items-center justify-center cursor-pointer select-none"
      >
        <div className="text-center">
          {flipped ? (
            <>
              <p className="text-xs text-gray-400 uppercase tracking-wider mb-4">Answer</p>
              <p className="text-4xl md:text-5xl font-bold text-[#0A2061]">{current.answer}</p>
            </>
          ) : (
            <>
              <p className="text-xs text-gray-400 uppercase tracking-wider mb-4">Question</p>
              <p className="text-6xl md:text-8xl">{current.question}</p>
            </>
          )}
          <p className="text-xs text-gray-300 mt-8">Tap to {flipped ? 'see question' : 'reveal answer'}</p>
        </div>
      </div>

      {/* Navigation */}
      <div className="flex items-center justify-between mt-6">
        <button onClick={() => goTo(Math.max(0, index - 1))} disabled={index === 0}
          className="flex items-center gap-2 px-5 py-2.5 rounded-full border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed transition">
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 19l-7-7 7-7" strokeWidth="2"/></svg>
          Previous
        </button>

        <div className="flex gap-1.5">
          {cards.map((_, i) => (
            <button key={i} onClick={() => goTo(i)}
              className={`w-2.5 h-2.5 rounded-full transition ${
                i === index ? 'bg-[#0C52AF] scale-125' : 'bg-gray-200 hover:bg-gray-300'
              }`}
            />
          ))}
        </div>

        <button onClick={() => goTo(Math.min(cards.length - 1, index + 1))} disabled={index === cards.length - 1}
          className="flex items-center gap-2 px-5 py-2.5 rounded-full border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed transition">
          Next
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M9 5l7 7-7 7" strokeWidth="2"/></svg>
        </button>
      </div>

      {/* Shuffle */}
      <div className="text-center mt-4">
        <button onClick={() => goTo(Math.floor(Math.random() * cards.length))}
          className="text-xs text-gray-400 hover:text-[#0C52AF] transition">
          🔀 Shuffle
        </button>
      </div>
    </div>
  )
}
