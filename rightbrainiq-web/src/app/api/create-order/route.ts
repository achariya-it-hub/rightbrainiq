import { NextResponse } from 'next/server'

export async function POST(req: Request) {
  try {
    const { order_amount, customer_phone, customer_name, customer_email } = await req.json()

    if (!order_amount || !customer_phone) {
      return NextResponse.json(
        { success: false, message: 'Missing required fields: order_amount, customer_phone' },
        { status: 400 }
      )
    }

    if (!process.env.CASHFREE_APP_ID || !process.env.CASHFREE_SECRET_KEY) {
      return NextResponse.json(
        { success: false, message: 'Cashfree not configured on server' },
        { status: 503 }
      )
    }

    const orderId = `RB_${Date.now()}`

    const response = await fetch('https://sandbox.cashfree.com/pg/orders', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-client-id': process.env.CASHFREE_APP_ID,
        'x-client-secret': process.env.CASHFREE_SECRET_KEY,
        'x-api-version': '2023-08-01',
      },
      body: JSON.stringify({
        order_id: orderId,
        order_amount: order_amount,
        order_currency: 'INR',
        customer_details: {
          customer_id: `cust_${Date.now()}`,
          customer_name: customer_name || 'Guest',
          customer_email: customer_email || 'guest@example.com',
          customer_phone,
        },
        order_meta: {
          return_url: `${process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'}/checkout?order_id=${orderId}`,
        },
      }),
    })

    const data = await response.json()

    if (!response.ok) {
      return NextResponse.json(
        { success: false, message: data.message || 'Failed to create order' },
        { status: response.status }
      )
    }

    return NextResponse.json({ success: true, data })
  } catch (error) {
    console.error('Order creation error:', error)
    return NextResponse.json(
      { success: false, message: 'Internal server error' },
      { status: 500 }
    )
  }
}
