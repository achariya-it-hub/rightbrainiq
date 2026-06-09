-- RightBrainIQ Seed Data
-- Run this after schema.sql in the Supabase SQL Editor

-- =====================================
-- CATEGORIES
-- =====================================
INSERT INTO categories (name, slug, product_count, image_url, description) VALUES
  ('SMART START CARDS', 'smart-start-cards', 100, 'https://rightbrainiq.com/wp-content/uploads/2025/11/SMART-START-CARDS-600x600.jpg', 'Foundation learning cards for early brain development'),
  ('CONNECT CARDS', 'connect-cards', 6, 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-CARDS-600x600.jpg', 'Associative learning cards for pattern recognition'),
  ('GEO CARDS', 'geo-cards', 50, 'https://rightbrainiq.com/wp-content/uploads/2025/10/GEO-card-Front-image-600x600.webp', 'Geography cards exploring places around the world'),
  ('MINI GLOBE CARDS', 'mini-globe-cards', 50, 'https://rightbrainiq.com/wp-content/uploads/2025/10/Mini-globe-cards-Front-Image-600x600.webp', 'Country cards for global awareness'),
  ('JUMBO CARDS', 'jumbo-pack', 10, 'https://rightbrainiq.com/wp-content/uploads/2025/10/JUMBO-CARDS-1-600x600.jpg', 'Large format flash cards for immersive learning'),
  ('HIGH CONTRAST', 'high-contrast', 6, 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Con-1-600x600.jpg', 'High contrast cards for infant visual stimulation');

-- =====================================
-- PRODUCTS - SMART START CARDS
-- =====================================
INSERT INTO products (id, name, category_slug, price, currency, image_url, image_url2, card_count, color) VALUES
  ('ss-1', 'FLAGS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FLAGS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/flag-1-600x600.jpg', 20, 'red'),
  ('ss-2', 'ANIMALS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/ANIMALS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/ANIMALS-1-600x600.jpg', 20, 'orange'),
  ('ss-3', 'FRUITS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FRUITS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FRUITS-1-600x600.webp', 20, 'yellow'),
  ('ss-4', 'VEGETABLES', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/VEGETABLES-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/VEGETABLES-1-600x600.webp', 20, 'green'),
  ('ss-5', 'BIRDS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/BIRDS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/Birds-1-600x600.jpg', 20, 'teal'),
  ('ss-6', 'FLOWERS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FLOWERS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/FLOWERS-1-600x600.jpg', 20, 'pink'),
  ('ss-7', 'TRANSPORT', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/TRANSPORT-600x600.jpg', NULL, 20, 'blue'),
  ('ss-8', 'COLOURS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/COLOURS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/COLOURS-3-600x600.jpg', 20, 'purple'),
  ('ss-9', 'SHAPES', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/SHAPES-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/SHAPES-2-600x600.jpg', 20, 'indigo'),
  ('ss-10', 'ALPHABETS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/Alphabets-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/ALPHABETS-1-600x600.jpg', 26, 'red'),
  ('ss-11', 'PROFESSIONS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/PROFESSION-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/PROFESSIONS-1-600x600.jpg', 20, 'orange'),
  ('ss-12', 'DAYS & MONTH', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/MONTHS-AND-DAYS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/DAYS-AND-MONTH-1-600x600.jpg', 19, 'teal'),
  ('ss-13', 'BODY PARTS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/PARTS-OF-THE-BODY_-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/PARTS-OF-THE-BODY-1-600x600.webp', 20, 'green'),
  ('ss-14', 'SPORTS', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/SPORTS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/2-600x600.jpg', 20, 'blue'),
  ('ss-15', 'HOME APPLIANCES', 'smart-start-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/HOME-APPLIANCES-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/HOME-APPLIANCES-1-600x600.jpg', 20, 'yellow');

-- =====================================
-- PRODUCTS - CONNECT CARDS
-- =====================================
INSERT INTO products (id, name, category_slug, price, currency, image_url, image_url2, card_count, color) VALUES
  ('cc-1', 'Connect Cards 1', 'connect-cards', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Cards-1-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Card-1-1-600x600.jpg', 30, 'purple'),
  ('cc-2', 'Connect Cards 2', 'connect-cards', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Cards-2-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Card-2-1-600x600.jpg', 30, 'teal'),
  ('cc-3', 'Connect Cards 3', 'connect-cards', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Cards-4-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Card-3-2-600x600.jpg', 30, 'orange'),
  ('cc-4', 'Connect Cards 4', 'connect-cards', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Cards-5-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Card-4-1-600x600.jpg', 30, 'green'),
  ('cc-5', 'Connect Cards 5', 'connect-cards', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Cards-6-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/10/Connect-Card-5-1-600x600.jpg', 30, 'red'),
  ('cc-6', 'Connect Cards 6', 'connect-cards', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2026/01/Connect-Cards-temphlet-6-600x600.jpg', NULL, 30, 'blue');

-- =====================================
-- PRODUCTS - GEO CARDS
-- =====================================
INSERT INTO products (id, name, category_slug, price, currency, image_url, image_url2, card_count, color) VALUES
  ('geo-1', 'AIRPORT', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AIRPORT-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AIRPORT-1-600x600.webp', 20, 'blue'),
  ('geo-2', 'AMUSEMENT PARK', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AMUSEMENT-PARK-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AMUSEMENT-PARK-1-600x600.webp', 20, 'yellow'),
  ('geo-3', 'ART GALLERY', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/Art-Gallery-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/ART-GALLERY-1-600x600.webp', 20, 'purple'),
  ('geo-4', 'BAKERY', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BAKERY-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BAKERY-1-600x600.webp', 20, 'orange'),
  ('geo-5', 'BANK', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BANK-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BANK-1-600x600.webp', 20, 'green'),
  ('geo-6', 'BEACH', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BEACH-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BEACH-1-600x600.webp', 20, 'teal'),
  ('geo-7', 'BEDROOM', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BEDROOM-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BEDROOM-1-600x600.webp', 20, 'pink'),
  ('geo-8', 'BOOK STORE', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BOOK-STORE-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BOOK-STORE-2-600x600.webp', 20, 'indigo'),
  ('geo-9', 'CAFE', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CAFE-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CAFE-1-600x600.webp', 20, 'red'),
  ('geo-10', 'CHURCH', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CHURCH-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CHURCH-1-600x600.webp', 20, 'purple'),
  ('geo-11', 'CINEMA THEATRE', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CINEMA-THEATRE-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CINEMA-THEATRE-1-600x600.webp', 20, 'orange'),
  ('geo-12', 'FARM', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/FARMGEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/FARM-1-600x600.webp', 20, 'green'),
  ('geo-13', 'FIRE STATION', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/fire-station-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/FIRE-STATION-1-600x600.webp', 20, 'red'),
  ('geo-14', 'GARDEN', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/Garden-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/GARDEN-1-600x600.webp', 20, 'green'),
  ('geo-15', 'HOSPITAL', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/HOSPITAL-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/HOSPITAL-1-600x600.webp', 20, 'red'),
  ('geo-16', 'LIBRARY', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/LIBRARY-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/LIBRARY-1-600x600.webp', 20, 'indigo'),
  ('geo-17', 'MALL', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MALL-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MALL-1-600x600.webp', 20, 'yellow'),
  ('geo-18', 'MOSQUE', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MOSQUE-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MOSQUE-1-600x600.webp', 20, 'teal'),
  ('geo-19', 'MUSEUM', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MUSEUM-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MUSEUM-1-600x600.webp', 20, 'purple'),
  ('geo-20', 'PARK', 'geo-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/PARK-GEO-CARD-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/PARK-1-600x600.webp', 20, 'green');

-- =====================================
-- PRODUCTS - MINI GLOBE CARDS
-- =====================================
INSERT INTO products (id, name, category_slug, price, currency, image_url, image_url2, card_count, color) VALUES
  ('mg-1', 'AFGHANISTAN', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AFGHANISTAN-Card-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AFGHANISTAN-1-600x600.webp', 20, 'red'),
  ('mg-2', 'AUSTRALIA', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AUSTRALIA-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/AUSTRALIA-1-600x600.webp', 20, 'teal'),
  ('mg-3', 'BRAZIL', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BRAZIL-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/BRAZIL-1-600x600.webp', 20, 'green'),
  ('mg-4', 'CANADA', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CANADA-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CANADA-1-600x600.webp', 20, 'red'),
  ('mg-5', 'CHINA', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CHINA-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CHINA-1-600x600.webp', 20, 'red'),
  ('mg-6', 'EGYPT', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/EGYPT-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/EGYPT-1-600x600.webp', 20, 'yellow'),
  ('mg-7', 'FRANCE', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/FRANCE-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/FRANCE-1-600x600.webp', 20, 'blue'),
  ('mg-8', 'GERMANY', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/GERMANY-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/GERMANY-1-600x600.webp', 20, 'orange'),
  ('mg-9', 'INDIA', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/INDIA-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/INDIA-1-600x600.webp', 20, 'orange'),
  ('mg-10', 'JAPAN', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/JAPAN-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/JAPAN-1-600x600.webp', 20, 'red'),
  ('mg-11', 'RUSSIA', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/RUSSIA-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/RUSSIA-1-600x600.webp', 20, 'indigo'),
  ('mg-12', 'UK', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/UK-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/UK-1-600x600.webp', 20, 'blue'),
  ('mg-13', 'USA', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/USA-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/USA-1-600x600.webp', 20, 'red'),
  ('mg-14', 'ITALY', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/ITALY-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/ITALY-1-600x600.webp', 20, 'green'),
  ('mg-15', 'SOUTH AFRICA', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/SOUTH-AFRICA-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/SOUTH-AFRICA-1-600x600.webp', 20, 'yellow'),
  ('mg-16', 'SINGAPORE', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/SINGAPORE-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/SINGAPORE-1-600x600.webp', 20, 'red'),
  ('mg-17', 'SWITZERLAND', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/SWITZERLAND-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/SWITZERLAND-1-600x600.webp', 20, 'red'),
  ('mg-18', 'UAE', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/UAE-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/UAE-1-600x600.webp', 20, 'green'),
  ('mg-19', 'NEPAL', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/NEPAL-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/NEPAL-1-600x600.webp', 20, 'blue'),
  ('mg-20', 'MEXICO', 'mini-globe-cards', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MEXICO-Card-1-600x600.webp', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MEXICO-1-600x600.webp', 20, 'green');

-- =====================================
-- PRODUCTS - JUMBO CARDS
-- =====================================
INSERT INTO products (id, name, category_slug, price, currency, image_url, image_url2, card_count, color) VALUES
  ('jb-1', 'Animals', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/ANIMALS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/ANIMALS-1-600x600.jpg', 20, 'green'),
  ('jb-2', 'Birds', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/BIRDS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/Birds-1-600x600.jpg', 20, 'teal'),
  ('jb-3', 'Flags', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FLAGS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/flag-1-600x600.jpg', 20, 'red'),
  ('jb-4', 'Fruits', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FRUITS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FRUITS-1-600x600.webp', 20, 'orange'),
  ('jb-5', 'Vegetables', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/VEGETABLES-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/VEGETABLES-1-600x600.webp', 20, 'green'),
  ('jb-6', 'Flowers', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/FLOWERS-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/FLOWERS-3-600x600.jpg', 20, 'pink'),
  ('jb-7', 'Car Logos', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/CAR-LOGOS-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/CAR-LOGOS-1-600x600.jpg', 20, 'blue'),
  ('jb-8', 'Transport', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/TRANSPORT-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/08/Transport-2-600x600.jpg', 20, 'yellow'),
  ('jb-9', 'Musical Instrument', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/MUSICAL-INSTRUMENT-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/09/MUSICAL-INSTRUMENT-1-600x600.jpg', 20, 'purple'),
  ('jb-10', 'World Persons', 'jumbo-pack', 1568, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/08/OLYMPIC-GAMES-1-600x600.jpg', NULL, 20, 'red');

-- =====================================
-- PRODUCTS - HIGH CONTRAST
-- =====================================
INSERT INTO products (id, name, category_slug, price, currency, image_url, image_url2, card_count, color) VALUES
  ('hc-1', 'High Contrast Set-1', 'high-contrast', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-1-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-1-2-600x600.jpg', 20, 'red'),
  ('hc-2', 'High Contrast Set-2', 'high-contrast', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-2-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-2-2-600x600.jpg', 20, 'orange'),
  ('hc-3', 'High Contrast Set-3', 'high-contrast', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-3-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-3-2-600x600.jpg', 20, 'yellow'),
  ('hc-4', 'High Contrast Set-4', 'high-contrast', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-4-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-4-2-600x600.jpg', 20, 'green'),
  ('hc-5', 'High Contrast Set-5', 'high-contrast', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-5-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-5-2-600x600.jpg', 20, 'blue'),
  ('hc-6', 'High Contrast Set-6', 'high-contrast', 340, '₹', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-6-1-600x600.jpg', 'https://rightbrainiq.com/wp-content/uploads/2025/10/High-Contrest-6-2-600x600.jpg', 20, 'purple');
