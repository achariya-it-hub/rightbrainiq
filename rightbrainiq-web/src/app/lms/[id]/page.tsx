'use client'

import { useParams } from 'next/navigation'
import Link from 'next/link'
import { getCourse } from '@/lib/lms/data'
import { useState } from 'react'

const colorMap: Record<string, string> = {
  '#0C52AF': 'from-[#0C52AF] to-blue-400',
  '#A52883': 'from-[#A52883] to-pink-400',
  '#49933F': 'from-[#49933F] to-green-400',
  '#FCA10C': 'from-[#FCA10C] to-yellow-400',
  '#FC641E': 'from-[#FC641E] to-orange-400',
  '#EC2E4F': 'from-[#EC2E4F] to-red-400',
}

export default function CourseDetailPage() {
  const params = useParams()
  const course = getCourse(params.id as string)
  const [activeMod, setActiveMod] = useState(0)

  if (!course) {
    return (
      <div className="max-w-3xl mx-auto px-4 py-20 text-center">
        <div className="text-7xl mb-6">📚</div>
        <h1 className="text-3xl font-bold text-gray-800 mb-3">Course not found</h1>
        <Link href="/lms" className="btn-primary text-lg inline-block">Back to LMS</Link>
      </div>
    )
  }

  return (
    <div className="max-w-5xl mx-auto px-4 py-8">
      <div className="flex items-center gap-2 text-sm text-gray-400 mb-6">
        <Link href="/" className="hover:text-[#0C52AF]">Home</Link>
        <span>/</span>
        <Link href="/lms" className="hover:text-[#0C52AF]">LMS</Link>
        <span>/</span>
        <span className="text-gray-700 font-medium">{course.title}</span>
      </div>

      {/* Header */}
      <div className={`rounded-3xl p-8 bg-gradient-to-br ${colorMap[course.color] || 'from-[#0C52AF] to-blue-400'} text-white mb-8 flex flex-col sm:flex-row gap-6 items-center`}>
        <img src={course.imageUrl} alt={course.title} className="w-32 h-32 object-contain drop-shadow-lg" />
        <div>
          <h1 className="text-3xl font-bold mb-2">{course.title}</h1>
          <p className="text-white/80 mb-1">{course.subtitle}</p>
          <p className="text-sm text-white/60">{course.totalLessons} lessons · {course.durationMinutes} min</p>
          {course.videoUrl && (
            <a href={course.videoUrl} target="_blank" rel="noopener noreferrer"
              className="inline-flex items-center gap-2 mt-3 bg-white/20 hover:bg-white/30 rounded-full px-4 py-2 text-sm font-medium transition">
              <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
              Watch Tutorial
            </a>
          )}
        </div>
      </div>

      {/* Description */}
      <div className="card-3d p-6 mb-8">
        <h2 className="font-bold text-lg text-gray-800 mb-2">About this Course</h2>
        <p className="text-gray-500 text-sm leading-relaxed">{course.description}</p>
      </div>

      {/* Modules */}
      <h2 className="font-bold text-xl text-[#0A2061] mb-4">Course Content</h2>
      <div className="space-y-4">
        {course.modules.map((mod, mi) => (
          <div key={mod.id} className="card-3d overflow-hidden">
            <button
              onClick={() => setActiveMod(activeMod === mi ? -1 : mi)}
              className="w-full flex items-center justify-between p-5 text-left"
            >
              <div>
                <h3 className="font-bold text-gray-800">{mod.title}</h3>
                <p className="text-xs text-gray-400 mt-0.5">{mod.lessonCount} lessons</p>
              </div>
              <svg className={`w-5 h-5 text-gray-400 transition-transform ${activeMod === mi ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M19 9l-7 7-7-7" strokeWidth="2"/></svg>
            </button>
            {activeMod === mi && (
              <div className="border-t border-gray-100">
                {mod.lessons.map((lesson, li) => (
                  <Link key={lesson.id} href={`/lms/${course.id}/${lesson.id}`}
                    className={`flex items-center gap-4 px-5 py-3.5 hover:bg-blue-50/50 transition group ${
                      li < mod.lessons.length - 1 ? 'border-b border-gray-50' : ''
                    }`}
                  >
                    <div className="w-8 h-8 rounded-full bg-gray-100 flex items-center justify-center text-xs font-bold text-gray-500 group-hover:bg-[#0C52AF] group-hover:text-white transition">
                      {li + 1}
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-gray-700 group-hover:text-[#0C52AF] transition truncate">
                        {lesson.title}
                      </p>
                      <p className="text-xs text-gray-400 capitalize">{lesson.type} · {lesson.cardCount} cards</p>
                    </div>
                    <svg className="w-4 h-4 text-gray-300 group-hover:text-[#0C52AF] transition" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M9 5l7 7-7 7" strokeWidth="2"/></svg>
                  </Link>
                ))}
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  )
}
