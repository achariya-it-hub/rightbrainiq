import { NextResponse } from 'next/server'
import crypto from 'crypto'

export async function POST(req: Request) {
  try {
    const rawBody = await req.text()
    const signature = req.headers.get('x-webhook-signature')
    const timestamp = req.headers.get('x-webhook-timestamp')

    if (!signature || !timestamp) {
      return NextResponse.json({ ok: true }, { status: 200 })
    }

    const signedPayload = timestamp + rawBody
    const expectedSignature = crypto
      .createHmac('sha256', process.env.CASHFREE_SECRET_KEY || '')
      .update(signedPayload)
      .digest('base64')

    if (signature !== expectedSignature) {
      return NextResponse.json({ error: 'Invalid signature' }, { status: 401 })
    }

    const event = JSON.parse(rawBody)

    if (event.type === 'PAYMENT_SUCCESS' || event.type === 'PAYMENT_SUCCESS_WEBHOOK') {
      const orderId = event.data.order.order_id
      console.log('Payment succeeded for order:', orderId)
    }

    if (event.type === 'PAYMENT_FAILED' || event.type === 'PAYMENT_FAILED_WEBHOOK') {
      const orderId = event.data.order.order_id
      console.log('Payment failed for order:', orderId)
    }

    return NextResponse.json({ ok: true })
  } catch (error) {
    console.error('Webhook error:', error)
    return NextResponse.json({ ok: true }, { status: 200 })
  }
}
