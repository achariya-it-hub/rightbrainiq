export type Flashcard = {
  question: string
  answer: string
}

export type LmsLesson = {
  id: string
  title: string
  type: string
  cardCount: number
  cards: Flashcard[]
  videoUrl?: string
}

export type LmsModule = {
  id: string
  title: string
  description: string
  lessonCount: number
  lessons: LmsLesson[]
}

export type LmsCourse = {
  id: string
  title: string
  subtitle: string
  description: string
  imageUrl: string
  categorySlug: string
  totalLessons: number
  durationMinutes: number
  color: string
  videoUrl?: string
  modules: LmsModule[]
}

const _baseUrl = 'https://rightbrainiq.com/wp-content/uploads'

const _flagsCards: Flashcard[] = [
  { question: '🇮🇳', answer: 'India' }, { question: '🇺🇸', answer: 'United States' }, { question: '🇬🇧', answer: 'United Kingdom' },
  { question: '🇫🇷', answer: 'France' }, { question: '🇩🇪', answer: 'Germany' }, { question: '🇯🇵', answer: 'Japan' },
  { question: '🇨🇳', answer: 'China' }, { question: '🇧🇷', answer: 'Brazil' }, { question: '🇦🇺', answer: 'Australia' },
  { question: '🇨🇦', answer: 'Canada' }, { question: '🇷🇺', answer: 'Russia' }, { question: '🇿🇦', answer: 'South Africa' },
  { question: '🇮🇹', answer: 'Italy' }, { question: '🇪🇸', answer: 'Spain' }, { question: '🇦🇷', answer: 'Argentina' },
  { question: '🇰🇷', answer: 'South Korea' }, { question: '🇸🇬', answer: 'Singapore' }, { question: '🇦🇪', answer: 'UAE' },
  { question: '🇳🇿', answer: 'New Zealand' }, { question: '🇨🇭', answer: 'Switzerland' },
]

const _animalsCards: Flashcard[] = [
  { question: '🐶', answer: 'Dog' }, { question: '🐱', answer: 'Cat' }, { question: '🐘', answer: 'Elephant' },
  { question: '🦁', answer: 'Lion' }, { question: '🐯', answer: 'Tiger' }, { question: '🐒', answer: 'Monkey' },
  { question: '🦒', answer: 'Giraffe' }, { question: '🐻', answer: 'Bear' }, { question: '🐼', answer: 'Panda' },
  { question: '🦊', answer: 'Fox' }, { question: '🐰', answer: 'Rabbit' }, { question: '🐸', answer: 'Frog' },
  { question: '🐧', answer: 'Penguin' }, { question: '🦅', answer: 'Eagle' }, { question: '🐬', answer: 'Dolphin' },
  { question: '🦈', answer: 'Shark' }, { question: '🐍', answer: 'Snake' }, { question: '🐢', answer: 'Turtle' },
  { question: '🦋', answer: 'Butterfly' }, { question: '🐝', answer: 'Bee' },
]

const _alphabetsCards: Flashcard[] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((letter, i) => ({
  question: letter,
  answer: `${letter} — ${['Apple', 'Ball', 'Cat', 'Dog', 'Egg', 'Fish', 'Girl', 'Hat', 'Ice', 'Juice', 'Kite', 'Lion', 'Monkey', 'Nest', 'Orange', 'Pen', 'Queen', 'Rabbit', 'Sun', 'Tree', 'Umbrella', 'Van', 'Watch', 'X-ray', 'Yacht', 'Zebra'][i]}`,
}))

const _coloursCards: Flashcard[] = [
  { question: '🔴', answer: 'Red' }, { question: '🟠', answer: 'Orange' }, { question: '🟡', answer: 'Yellow' },
  { question: '🟢', answer: 'Green' }, { question: '🔵', answer: 'Blue' }, { question: '🟣', answer: 'Purple' },
  { question: '⚪', answer: 'White' }, { question: '⚫', answer: 'Black' }, { question: '🟤', answer: 'Brown' },
  { question: '🩷', answer: 'Pink' }, { question: '🩶', answer: 'Grey' }, { question: '🩵', answer: 'Light Blue' },
]

const _defaultCards = (topic: string): Flashcard[] =>
  Array.from({ length: 20 }, (_, i) => ({
    question: `${topic} ${i + 1}`,
    answer: `Learn about ${topic} — Card ${i + 1}`,
  }))

export const lmsCourses: LmsCourse[] = [
  {
    id: 'smart-start',
    title: 'Smart Start Cards',
    subtitle: 'Foundation learning for early brain development',
    description: 'Master the basics with our comprehensive Smart Start flashcard series. Covers 15 essential topics including animals, flags, fruits, vegetables, and more.',
    imageUrl: '$_baseUrl/2025/11/SMART-START-CARDS-600x600.jpg',
    categorySlug: 'smart-start-cards',
    totalLessons: 15,
    durationMinutes: 300,
    color: '#0C52AF',
    videoUrl: 'https://www.youtube.com/watch?v=example',
    modules: [
      {
        id: 'ss-mod-1', title: 'Introduction', description: 'Getting started with Smart Start', lessonCount: 5,
        lessons: [
          { id: 'ss-lesson-1', title: 'Flags of the World', type: 'flashcard', cardCount: 20, cards: _flagsCards },
          { id: 'ss-lesson-2', title: 'Animals', type: 'flashcard', cardCount: 20, cards: _animalsCards },
          { id: 'ss-lesson-3', title: 'Fruits', type: 'flashcard', cardCount: 20, cards: _defaultCards('Fruits') },
          { id: 'ss-lesson-4', title: 'Vegetables', type: 'flashcard', cardCount: 20, cards: _defaultCards('Vegetables') },
          { id: 'ss-lesson-5', title: 'Birds', type: 'flashcard', cardCount: 20, cards: _defaultCards('Birds') },
        ],
      },
      {
        id: 'ss-mod-2', title: 'Intermediate', description: 'Build on your knowledge', lessonCount: 5,
        lessons: [
          { id: 'ss-lesson-6', title: 'Flowers', type: 'flashcard', cardCount: 20, cards: _defaultCards('Flowers') },
          { id: 'ss-lesson-7', title: 'Transport', type: 'flashcard', cardCount: 20, cards: _defaultCards('Transport') },
          { id: 'ss-lesson-8', title: 'Colours', type: 'flashcard', cardCount: 20, cards: _coloursCards },
          { id: 'ss-lesson-9', title: 'Shapes', type: 'flashcard', cardCount: 20, cards: _defaultCards('Shapes') },
          { id: 'ss-lesson-10', title: 'Alphabets', type: 'flashcard', cardCount: 26, cards: _alphabetsCards },
        ],
      },
    ],
  },
  {
    id: 'connect-cards',
    title: 'Connect Cards',
    subtitle: 'Associative learning for pattern recognition',
    description: 'Enhance cognitive connections with our associative learning card system. Build neural pathways through pattern recognition.',
    imageUrl: '$_baseUrl/2025/10/Connect-CARDS-600x600.jpg',
    categorySlug: 'connect-cards',
    totalLessons: 6,
    durationMinutes: 180,
    color: '#A52883',
    videoUrl: 'https://www.youtube.com/watch?v=example',
    modules: [
      {
        id: 'cc-mod-1', title: 'All Connect Cards', description: 'Complete Connect Card series', lessonCount: 6,
        lessons: [
          { id: 'cc-lesson-1', title: 'Connect Cards 1', type: 'flashcard', cardCount: 30, cards: _defaultCards('Connect 1') },
          { id: 'cc-lesson-2', title: 'Connect Cards 2', type: 'flashcard', cardCount: 30, cards: _defaultCards('Connect 2') },
          { id: 'cc-lesson-3', title: 'Connect Cards 3', type: 'flashcard', cardCount: 30, cards: _defaultCards('Connect 3') },
          { id: 'cc-lesson-4', title: 'Connect Cards 4', type: 'flashcard', cardCount: 30, cards: _defaultCards('Connect 4') },
          { id: 'cc-lesson-5', title: 'Connect Cards 5', type: 'flashcard', cardCount: 30, cards: _defaultCards('Connect 5') },
          { id: 'cc-lesson-6', title: 'Connect Cards 6', type: 'flashcard', cardCount: 30, cards: _defaultCards('Connect 6') },
        ],
      },
    ],
  },
  {
    id: 'geo-cards',
    title: 'Geo Cards',
    subtitle: 'Explore places around the world',
    description: 'Discover fascinating places from airports to museums. Build geography awareness through engaging flashcard content.',
    imageUrl: '$_baseUrl/2025/10/GEO-card-Front-image-600x600.webp',
    categorySlug: 'geo-cards',
    totalLessons: 20,
    durationMinutes: 400,
    color: '#49933F',
    videoUrl: 'https://www.youtube.com/watch?v=example',
    modules: [
      {
        id: 'geo-mod-1', title: 'Places Around Us', description: 'Explore common places', lessonCount: 10,
        lessons: [
          ...['Airport', 'Amusement Park', 'Art Gallery', 'Bakery', 'Bank', 'Beach', 'Bedroom', 'Book Store', 'Cafe', 'Church'].map((name, i) => ({
            id: `geo-lesson-${i + 1}`, title: name, type: 'flashcard' as const, cardCount: 20, cards: _defaultCards(name),
          })),
        ],
      },
    ],
  },
  {
    id: 'mini-globe',
    title: 'Mini Globe Cards',
    subtitle: 'Countries of the world',
    description: 'Learn about countries from Afghanistan to Mexico. Build global awareness with our Mini Globe card series.',
    imageUrl: '$_baseUrl/2025/10/Mini-globe-cards-Front-Image-600x600.webp',
    categorySlug: 'mini-globe-cards',
    totalLessons: 20,
    durationMinutes: 400,
    color: '#FCA10C',
    videoUrl: 'https://www.youtube.com/watch?v=example',
    modules: [
      {
        id: 'mg-mod-1', title: 'Countries A-M', description: 'Countries from around the world', lessonCount: 10,
        lessons: [
          ...['Afghanistan', 'Australia', 'Brazil', 'Canada', 'China', 'Egypt', 'France', 'Germany', 'India', 'Japan'].map((name, i) => ({
            id: `mg-lesson-${i + 1}`, title: name, type: 'flashcard' as const, cardCount: 20, cards: _defaultCards(name),
          })),
        ],
      },
    ],
  },
  {
    id: 'jumbo',
    title: 'Jumbo Cards',
    subtitle: 'Large format immersive learning',
    description: 'Large format flash cards for immersive learning. Bigger cards, bigger impact on early brain development.',
    imageUrl: '$_baseUrl/2025/10/JUMBO-CARDS-1-600x600.jpg',
    categorySlug: 'jumbo-pack',
    totalLessons: 10,
    durationMinutes: 200,
    color: '#FC641E',
    videoUrl: 'https://www.youtube.com/watch?v=example',
    modules: [
      {
        id: 'jb-mod-1', title: 'Jumbo Collection', description: 'Complete Jumbo series', lessonCount: 10,
        lessons: [
          ...['Animals', 'Birds', 'Flags', 'Fruits', 'Vegetables', 'Flowers', 'Car Logos', 'Transport', 'Musical Instrument', 'World Persons'].map((name, i) => ({
            id: `jb-lesson-${i + 1}`, title: name, type: 'flashcard' as const, cardCount: 20, cards: _defaultCards(name),
          })),
        ],
      },
    ],
  },
  {
    id: 'high-contrast',
    title: 'High Contrast',
    subtitle: 'Visual stimulation for infants',
    description: 'High contrast black and white cards designed for infant visual development. Perfect for newborns and babies.',
    imageUrl: '$_baseUrl/2025/10/High-Con-1-600x600.jpg',
    categorySlug: 'high-contrast',
    totalLessons: 6,
    durationMinutes: 120,
    color: '#EC2E4F',
    videoUrl: 'https://www.youtube.com/watch?v=example',
    modules: [
      {
        id: 'hc-mod-1', title: 'All Sets', description: 'Complete High Contrast series', lessonCount: 6,
        lessons: [
          ...[1, 2, 3, 4, 5, 6].map(i => ({
            id: `hc-lesson-${i}`, title: `High Contrast Set-${i}`, type: 'flashcard' as const, cardCount: 20, cards: _defaultCards(`High Contrast ${i}`),
          })),
        ],
      },
    ],
  },
]

export function getCourse(id: string): LmsCourse | undefined {
  return lmsCourses.find(c => c.id === id)
}

export function getLesson(courseId: string, lessonId: string): LmsLesson | undefined {
  const course = getCourse(courseId)
  if (!course) return undefined
  for (const mod of course.modules) {
    const lesson = mod.lessons.find(l => l.id === lessonId)
    if (lesson) return lesson
  }
  return undefined
}
