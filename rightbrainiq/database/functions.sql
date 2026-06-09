-- Function to place an order with items in a transaction
CREATE OR REPLACE FUNCTION place_order(
  p_user_id UUID,
  p_total NUMERIC,
  p_payment_method TEXT,
  p_address TEXT,
  p_city TEXT,
  p_pincode TEXT,
  p_phone TEXT,
  p_items JSONB
) RETURNS UUID AS $$
DECLARE
  v_order_id UUID;
  v_item JSONB;
BEGIN
  -- Insert the order
  INSERT INTO orders (user_id, total, payment_method, address, city, pincode, phone)
  VALUES (p_user_id, p_total, p_payment_method, p_address, p_city, p_pincode, p_phone)
  RETURNING id INTO v_order_id;

  -- Insert each item
  FOR v_item IN SELECT * FROM jsonb_array_elements(p_items)
  LOOP
    INSERT INTO order_items (order_id, product_id, product_name, product_price, product_image, quantity)
    VALUES (
      v_order_id,
      v_item->>'product_id',
      v_item->>'product_name',
      (v_item->>'product_price')::NUMERIC,
      v_item->>'product_image',
      (v_item->>'quantity')::INT
    );
  END LOOP;

  -- Clear user's cart
  DELETE FROM cart_items WHERE user_id = p_user_id;

  RETURN v_order_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
