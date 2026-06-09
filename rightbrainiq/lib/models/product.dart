class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String currency;
  final String imageUrl;
  final String? imageUrl2;
  final int cardCount;
  final String description;
  final ColorCode color;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.currency = '₹',
    required this.imageUrl,
    this.imageUrl2,
    this.cardCount = 0,
    this.description = '',
    this.color = ColorCode.blue,
  });
}

enum ColorCode {
  red,
  orange,
  yellow,
  green,
  teal,
  blue,
  purple,
  pink,
  indigo,
}

extension ColorCodeExtension on ColorCode {
  int get hexValue {
    switch (this) {
      case ColorCode.red:
        return 0xFFEC2E4F;
      case ColorCode.orange:
        return 0xFFFC641E;
      case ColorCode.yellow:
        return 0xFFFCA10C;
      case ColorCode.green:
        return 0xFF49933F;
      case ColorCode.teal:
        return 0xFF0C52AF;
      case ColorCode.blue:
        return 0xFF0C52AF;
      case ColorCode.purple:
        return 0xFFA52883;
      case ColorCode.pink:
        return 0xFFE91E90;
      case ColorCode.indigo:
        return 0xFF0829CC;
    }
  }
}
