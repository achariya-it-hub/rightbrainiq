import { Suspense } from 'react'
import ProductsContent from './content'

export default function ProductsPage() {
  return (
    <Suspense fallback={
      <div className="max-w-7xl mx-auto px-4 py-8">
        <div className="animate-pulse">
          <div className="h-8 w-48 shimmer mb-4" />
          <div className="flex gap-2 mb-8">{[...Array(6)].map((_, i) => <div key={i} className="h-8 w-24 shimmer rounded-full" />)}</div>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">{[...Array(8)].map((_, i) => <div key={i} className="h-72 shimmer rounded-2xl" />)}</div>
        </div>
      </div>
    }>
      <ProductsContent />
    </Suspense>
  )
}
