import '../models/product.dart';
import '../models/category.dart';

class ProductRepository {
  static final _baseUrl = 'https://rightbrainiq.com/wp-content/uploads';
  static String get baseUrl => _baseUrl;

  static List<Category> get categories => [
        Category(
          name: 'SMART START CARDS',
          slug: 'smart-start-cards',
          productCount: 100,
          imageUrl: '$_baseUrl/2025/11/SMART-START-CARDS-600x600.jpg',
          description: 'Foundation learning cards for early brain development',
        ),
        Category(
          name: 'CONNECT CARDS',
          slug: 'connect-cards',
          productCount: 6,
          imageUrl: '$_baseUrl/2025/10/Connect-CARDS-600x600.jpg',
          description: 'Associative learning cards for pattern recognition',
        ),
        Category(
          name: 'GEO CARDS',
          slug: 'geo-cards',
          productCount: 50,
          imageUrl: '$_baseUrl/2025/10/GEO-card-Front-image-600x600.webp',
          description: 'Geography cards exploring places around the world',
        ),
        Category(
          name: 'MINI GLOBE CARDS',
          slug: 'mini-globe-cards',
          productCount: 50,
          imageUrl: '$_baseUrl/2025/10/Mini-globe-cards-Front-Image-600x600.webp',
          description: 'Country cards for global awareness',
        ),
        Category(
          name: 'JUMBO CARDS',
          slug: 'jumbo-pack',
          productCount: 10,
          imageUrl: '$_baseUrl/2025/10/JUMBO-CARDS-1-600x600.jpg',
          description: 'Large format flash cards for immersive learning',
        ),
        Category(
          name: 'HIGH CONTRAST',
          slug: 'high-contrast',
          productCount: 6,
          imageUrl: '$_baseUrl/2025/10/High-Con-1-600x600.jpg',
          description: 'High contrast cards for infant visual stimulation',
        ),
      ];

  static List<Product> get smartStartCards => [
        Product(id: 'ss-1', name: 'FLAGS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/FLAGS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/flag-1-600x600.jpg', cardCount: 20, color: ColorCode.red),
        Product(id: 'ss-2', name: 'ANIMALS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/ANIMALS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/ANIMALS-1-600x600.jpg', cardCount: 20, color: ColorCode.orange),
        Product(id: 'ss-3', name: 'FRUITS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/FRUITS-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/FRUITS-1-600x600.webp', cardCount: 20, color: ColorCode.yellow),
        Product(id: 'ss-4', name: 'VEGETABLES', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/VEGETABLES-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/VEGETABLES-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'ss-5', name: 'BIRDS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/BIRDS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/Birds-1-600x600.jpg', cardCount: 20, color: ColorCode.teal),
        Product(id: 'ss-6', name: 'FLOWERS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/FLOWERS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/FLOWERS-1-600x600.jpg', cardCount: 20, color: ColorCode.pink),
        Product(id: 'ss-7', name: 'TRANSPORT', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/TRANSPORT-600x600.jpg', cardCount: 20, color: ColorCode.blue),
        Product(id: 'ss-8', name: 'COLOURS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/COLOURS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/COLOURS-3-600x600.jpg', cardCount: 20, color: ColorCode.purple),
        Product(id: 'ss-9', name: 'SHAPES', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/SHAPES-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/SHAPES-2-600x600.jpg', cardCount: 20, color: ColorCode.indigo),
        Product(id: 'ss-10', name: 'ALPHABETS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/Alphabets-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/ALPHABETS-1-600x600.jpg', cardCount: 26, color: ColorCode.red),
        Product(id: 'ss-11', name: 'PROFESSIONS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/PROFESSION-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/PROFESSIONS-1-600x600.jpg', cardCount: 20, color: ColorCode.orange),
        Product(id: 'ss-12', name: 'DAYS & MONTH', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/MONTHS-AND-DAYS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/DAYS-AND-MONTH-1-600x600.jpg', cardCount: 19, color: ColorCode.teal),
        Product(id: 'ss-13', name: 'BODY PARTS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/PARTS-OF-THE-BODY_-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/PARTS-OF-THE-BODY-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'ss-14', name: 'SPORTS', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/SPORTS-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/2-600x600.jpg', cardCount: 20, color: ColorCode.blue),
        Product(id: 'ss-15', name: 'HOME APPLIANCES', category: 'SMART START CARDS', price: 340, imageUrl: '$_baseUrl/2025/08/HOME-APPLIANCES-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/HOME-APPLIANCES-1-600x600.jpg', cardCount: 20, color: ColorCode.yellow),
      ];

  static List<Product> get connectCards => [
        Product(id: 'cc-1', name: 'Connect Cards 1', category: 'CONNECT CARDS', price: 1568, imageUrl: '$_baseUrl/2025/10/Connect-Cards-1-1-600x600.webp', imageUrl2: '$_baseUrl/2025/10/Connect-Card-1-1-600x600.jpg', cardCount: 30, color: ColorCode.purple),
        Product(id: 'cc-2', name: 'Connect Cards 2', category: 'CONNECT CARDS', price: 1568, imageUrl: '$_baseUrl/2025/10/Connect-Cards-2-1-600x600.webp', imageUrl2: '$_baseUrl/2025/10/Connect-Card-2-1-600x600.jpg', cardCount: 30, color: ColorCode.teal),
        Product(id: 'cc-3', name: 'Connect Cards 3', category: 'CONNECT CARDS', price: 1568, imageUrl: '$_baseUrl/2025/10/Connect-Cards-4-1-600x600.webp', imageUrl2: '$_baseUrl/2025/10/Connect-Card-3-2-600x600.jpg', cardCount: 30, color: ColorCode.orange),
        Product(id: 'cc-4', name: 'Connect Cards 4', category: 'CONNECT CARDS', price: 1568, imageUrl: '$_baseUrl/2025/10/Connect-Cards-5-1-600x600.webp', imageUrl2: '$_baseUrl/2025/10/Connect-Card-4-1-600x600.jpg', cardCount: 30, color: ColorCode.green),
        Product(id: 'cc-5', name: 'Connect Cards 5', category: 'CONNECT CARDS', price: 1568, imageUrl: '$_baseUrl/2025/10/Connect-Cards-6-1-600x600.webp', imageUrl2: '$_baseUrl/2025/10/Connect-Card-5-1-600x600.jpg', cardCount: 30, color: ColorCode.red),
        Product(id: 'cc-6', name: 'Connect Cards 6', category: 'CONNECT CARDS', price: 1568, imageUrl: '$_baseUrl/2026/01/Connect-Cards-temphlet-6-600x600.jpg', cardCount: 30, color: ColorCode.blue),
      ];

  static List<Product> get geoCards => [
        Product(id: 'geo-1', name: 'AIRPORT', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/AIRPORT-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/AIRPORT-1-600x600.webp', cardCount: 20, color: ColorCode.blue),
        Product(id: 'geo-2', name: 'AMUSEMENT PARK', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/AMUSEMENT-PARK-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/AMUSEMENT-PARK-1-600x600.webp', cardCount: 20, color: ColorCode.yellow),
        Product(id: 'geo-3', name: 'ART GALLERY', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/Art-Gallery-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/ART-GALLERY-1-600x600.webp', cardCount: 20, color: ColorCode.purple),
        Product(id: 'geo-4', name: 'BAKERY', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/BAKERY-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/BAKERY-1-600x600.webp', cardCount: 20, color: ColorCode.orange),
        Product(id: 'geo-5', name: 'BANK', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/BANK-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/BANK-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'geo-6', name: 'BEACH', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/BEACH-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/BEACH-1-600x600.webp', cardCount: 20, color: ColorCode.teal),
        Product(id: 'geo-7', name: 'BEDROOM', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/BEDROOM-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/BEDROOM-1-600x600.webp', cardCount: 20, color: ColorCode.pink),
        Product(id: 'geo-8', name: 'BOOK STORE', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/BOOK-STORE-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/BOOK-STORE-2-600x600.webp', cardCount: 20, color: ColorCode.indigo),
        Product(id: 'geo-9', name: 'CAFE', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/CAFE-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/CAFE-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'geo-10', name: 'CHURCH', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/CHURCH-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/CHURCH-1-600x600.webp', cardCount: 20, color: ColorCode.purple),
        Product(id: 'geo-11', name: 'CINEMA THEATRE', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/CINEMA-THEATRE-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/CINEMA-THEATRE-1-600x600.webp', cardCount: 20, color: ColorCode.orange),
        Product(id: 'geo-12', name: 'FARM', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/FARMGEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/FARM-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'geo-13', name: 'FIRE STATION', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/fire-station-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/FIRE-STATION-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'geo-14', name: 'GARDEN', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/Garden-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/GARDEN-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'geo-15', name: 'HOSPITAL', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/HOSPITAL-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/HOSPITAL-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'geo-16', name: 'LIBRARY', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/LIBRARY-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/LIBRARY-1-600x600.webp', cardCount: 20, color: ColorCode.indigo),
        Product(id: 'geo-17', name: 'MALL', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/MALL-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/MALL-1-600x600.webp', cardCount: 20, color: ColorCode.yellow),
        Product(id: 'geo-18', name: 'MOSQUE', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/MOSQUE-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/MOSQUE-1-600x600.webp', cardCount: 20, color: ColorCode.teal),
        Product(id: 'geo-19', name: 'MUSEUM', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/MUSEUM-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/MUSEUM-1-600x600.webp', cardCount: 20, color: ColorCode.purple),
        Product(id: 'geo-20', name: 'PARK', category: 'GEO CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/PARK-GEO-CARD-600x600.webp', imageUrl2: '$_baseUrl/2025/09/PARK-1-600x600.webp', cardCount: 20, color: ColorCode.green),
      ];

  static List<Product> get miniGlobeCards => [
        Product(id: 'mg-1', name: 'AFGHANISTAN', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/AFGHANISTAN-Card-600x600.webp', imageUrl2: '$_baseUrl/2025/09/AFGHANISTAN-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'mg-2', name: 'AUSTRALIA', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/AUSTRALIA-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/AUSTRALIA-1-600x600.webp', cardCount: 20, color: ColorCode.teal),
        Product(id: 'mg-3', name: 'BRAZIL', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/BRAZIL-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/BRAZIL-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'mg-4', name: 'CANADA', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/CANADA-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/CANADA-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'mg-5', name: 'CHINA', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/CHINA-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/CHINA-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'mg-6', name: 'EGYPT', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/EGYPT-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/EGYPT-1-600x600.webp', cardCount: 20, color: ColorCode.yellow),
        Product(id: 'mg-7', name: 'FRANCE', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/FRANCE-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/FRANCE-1-600x600.webp', cardCount: 20, color: ColorCode.blue),
        Product(id: 'mg-8', name: 'GERMANY', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/GERMANY-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/GERMANY-1-600x600.webp', cardCount: 20, color: ColorCode.orange),
        Product(id: 'mg-9', name: 'INDIA', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/INDIA-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/INDIA-1-600x600.webp', cardCount: 20, color: ColorCode.orange),
        Product(id: 'mg-10', name: 'JAPAN', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/JAPAN-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/JAPAN-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'mg-11', name: 'RUSSIA', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/RUSSIA-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/RUSSIA-1-600x600.webp', cardCount: 20, color: ColorCode.indigo),
        Product(id: 'mg-12', name: 'UK', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/UK-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/UK-1-600x600.webp', cardCount: 20, color: ColorCode.blue),
        Product(id: 'mg-13', name: 'USA', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/USA-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/USA-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'mg-14', name: 'ITALY', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/ITALY-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/ITALY-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'mg-15', name: 'SOUTH AFRICA', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/SOUTH-AFRICA-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/SOUTH-AFRICA-1-600x600.webp', cardCount: 20, color: ColorCode.yellow),
        Product(id: 'mg-16', name: 'SINGAPORE', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/SINGAPORE-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/SINGAPORE-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'mg-17', name: 'SWITZERLAND', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/SWITZERLAND-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/SWITZERLAND-1-600x600.webp', cardCount: 20, color: ColorCode.red),
        Product(id: 'mg-18', name: 'UAE', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/UAE-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/UAE-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'mg-19', name: 'NEPAL', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/NEPAL-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/NEPAL-1-600x600.webp', cardCount: 20, color: ColorCode.blue),
        Product(id: 'mg-20', name: 'MEXICO', category: 'MINI GLOBE CARDS', price: 340, imageUrl: '$_baseUrl/2025/09/MEXICO-Card-1-600x600.webp', imageUrl2: '$_baseUrl/2025/09/MEXICO-1-600x600.webp', cardCount: 20, color: ColorCode.green),
      ];

  static List<Product> get jumboCards => [
        Product(id: 'jb-1', name: 'Animals', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/ANIMALS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/ANIMALS-1-600x600.jpg', cardCount: 20, color: ColorCode.green),
        Product(id: 'jb-2', name: 'Birds', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/BIRDS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/Birds-1-600x600.jpg', cardCount: 20, color: ColorCode.teal),
        Product(id: 'jb-3', name: 'Flags', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/FLAGS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/flag-1-600x600.jpg', cardCount: 20, color: ColorCode.red),
        Product(id: 'jb-4', name: 'Fruits', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/FRUITS-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/FRUITS-1-600x600.webp', cardCount: 20, color: ColorCode.orange),
        Product(id: 'jb-5', name: 'Vegetables', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/VEGETABLES-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/VEGETABLES-1-600x600.webp', cardCount: 20, color: ColorCode.green),
        Product(id: 'jb-6', name: 'Flowers', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/FLOWERS-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/FLOWERS-3-600x600.jpg', cardCount: 20, color: ColorCode.pink),
        Product(id: 'jb-7', name: 'Car Logos', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/CAR-LOGOS-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/CAR-LOGOS-1-600x600.jpg', cardCount: 20, color: ColorCode.blue),
        Product(id: 'jb-8', name: 'Transport', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/TRANSPORT-600x600.jpg', imageUrl2: '$_baseUrl/2025/08/Transport-2-600x600.jpg', cardCount: 20, color: ColorCode.yellow),
        Product(id: 'jb-9', name: 'Musical Instrument', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/MUSICAL-INSTRUMENT-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/09/MUSICAL-INSTRUMENT-1-600x600.jpg', cardCount: 20, color: ColorCode.purple),
        Product(id: 'jb-10', name: 'World Persons', category: 'JUMBO CARDS', price: 1568, imageUrl: '$_baseUrl/2025/08/OLYMPIC-GAMES-1-600x600.jpg', cardCount: 20, color: ColorCode.red),
      ];

  static List<Product> get highContrastCards => [
        Product(id: 'hc-1', name: 'High Contrast Set-1', category: 'HIGH CONTRAST', price: 340, imageUrl: '$_baseUrl/2025/10/High-Contrest-1-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/10/High-Contrest-1-2-600x600.jpg', cardCount: 20, color: ColorCode.red),
        Product(id: 'hc-2', name: 'High Contrast Set-2', category: 'HIGH CONTRAST', price: 340, imageUrl: '$_baseUrl/2025/10/High-Contrest-2-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/10/High-Contrest-2-2-600x600.jpg', cardCount: 20, color: ColorCode.orange),
        Product(id: 'hc-3', name: 'High Contrast Set-3', category: 'HIGH CONTRAST', price: 340, imageUrl: '$_baseUrl/2025/10/High-Contrest-3-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/10/High-Contrest-3-2-600x600.jpg', cardCount: 20, color: ColorCode.yellow),
        Product(id: 'hc-4', name: 'High Contrast Set-4', category: 'HIGH CONTRAST', price: 340, imageUrl: '$_baseUrl/2025/10/High-Contrest-4-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/10/High-Contrest-4-2-600x600.jpg', cardCount: 20, color: ColorCode.green),
        Product(id: 'hc-5', name: 'High Contrast Set-5', category: 'HIGH CONTRAST', price: 340, imageUrl: '$_baseUrl/2025/10/High-Contrest-5-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/10/High-Contrest-5-2-600x600.jpg', cardCount: 20, color: ColorCode.blue),
        Product(id: 'hc-6', name: 'High Contrast Set-6', category: 'HIGH CONTRAST', price: 340, imageUrl: '$_baseUrl/2025/10/High-Contrest-6-1-600x600.jpg', imageUrl2: '$_baseUrl/2025/10/High-Contrest-6-2-600x600.jpg', cardCount: 20, color: ColorCode.purple),
      ];

  static List<Product> get allProducts => [
        ...smartStartCards,
        ...connectCards,
        ...geoCards,
        ...miniGlobeCards,
        ...jumboCards,
        ...highContrastCards,
      ];

  static List<Product> getProductsByCategory(String categorySlug) {
    switch (categorySlug) {
      case 'smart-start-cards':
        return smartStartCards;
      case 'connect-cards':
        return connectCards;
      case 'geo-cards':
        return geoCards;
      case 'mini-globe-cards':
        return miniGlobeCards;
      case 'jumbo-pack':
        return jumboCards;
      case 'high-contrast':
        return highContrastCards;
      default:
        return allProducts;
    }
  }

  static Product? getProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
