'use client'

import Link from 'next/link'
import { useState } from 'react'
import { lmsCourses } from '@/lib/lms/data'

const colorMap: Record<string, string> = {
  '#0C52AF': 'from-[#0C52AF] to-blue-400',
  '#A52883': 'from-[#A52883] to-pink-400',
  '#49933F': 'from-[#49933F] to-green-400',
  '#FCA10C': 'from-[#FCA10C] to-yellow-400',
  '#FC641E': 'from-[#FC641E] to-orange-400',
  '#EC2E4F': 'from-[#EC2E4F] to-red-400',
}

export default function LmsPage() {
  const [search, setSearch] = useState('')

  const filtered = lmsCourses.filter(c =>
    c.title.toLowerCase().includes(search.toLowerCase()) ||
    c.description.toLowerCase().includes(search.toLowerCase())
  )

  return (
    <div className="max-w-6xl mx-auto px-4 py-8">
      <div className="flex items-center gap-2 text-sm text-gray-400 mb-6">
        <Link href="/" className="hover:text-[#0C52AF]">Home</Link>
        <span>/</span>
        <span className="text-gray-700 font-medium">LMS</span>
      </div>

      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-8">
        <div>
          <h1 className="text-3xl font-bold text-[#0A2061]">Learning Center</h1>
          <p className="text-gray-400 mt-1">Explore our flashcard courses</p>
        </div>
        <input type="text" placeholder="Search courses..." value={search} onChange={e => setSearch(e.target.value)}
          className="max-w-xs w-full p-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0C52AF]" />
      </div>

      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filtered.length === 0 ? (
          <div className="md:col-span-2 lg:col-span-3 text-center py-20 text-gray-400">
            No courses found for &quot;{search}&quot;
          </div>
        ) : filtered.map((course, i) => (
          <Link key={course.id} href={`/lms/${course.id}`} className="group animate-fade-in" style={{ animationDelay: `${i * 80}ms` }}>
            <div className="card-3d overflow-hidden">
              <div className={`h-40 bg-gradient-to-br ${colorMap[course.color] || 'from-[#0C52AF] to-blue-400'} flex items-center justify-center`}>
                <img src={course.imageUrl} alt={course.title}
                  className="h-32 w-32 object-contain drop-shadow-lg group-hover:scale-110 transition-transform duration-500" />
              </div>
              <div className="p-5">
                <h3 className="font-bold text-gray-800 text-lg mb-1 group-hover:text-[#0C52AF] transition-colors">
                  {course.title}
                </h3>
                <p className="text-sm text-gray-400 line-clamp-2 mb-3">{course.description}</p>
                <div className="flex items-center gap-4 text-xs text-gray-400">
                  <span className="flex items-center gap-1">
                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" strokeWidth="1.5"/></svg>
                    {course.durationMinutes} min
                  </span>
                  <span className="flex items-center gap-1">
                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" strokeWidth="1.5"/></svg>
                    {course.totalLessons} lessons
                  </span>
                </div>
              </div>
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}
