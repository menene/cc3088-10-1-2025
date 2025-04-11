CREATE OR REPLACE FUNCTION detail_sub_total()
RETURNS TRIGGER AS $$
BEGIN
  NEW.sub_total := NEW.quantity * NEW.unit_price;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_order_detail_trigger
BEFORE INSERT OR UPDATE ON order_details
FOR EACH ROW
EXECUTE FUNCTION detail_sub_total();

-- 

CREATE OR REPLACE FUNCTION order_total()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE orders
  SET total = (
    SELECT SUM(sub_total)
    FROM order_details
    WHERE order_id = NEW.order_id
  )
  WHERE id = NEW.order_id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_insert_order_details_trigger
AFTER INSERT OR UPDATE OR DELETE ON order_details
FOR EACH ROW
EXECUTE FUNCTION order_total();

-- 

CREATE OR REPLACE FUNCTION manage_stock()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE products
  SET stock = stock - NEW.quantity
  WHERE id = NEW.product_id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_insert_order_details_stock_trigger
AFTER INSERT OR UPDATE ON order_details
FOR EACH ROW
EXECUTE FUNCTION manage_stock();
