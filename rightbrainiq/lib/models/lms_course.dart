import 'lms_module.dart';

class LmsCourse {
  final String id;
  final String productId;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final String categorySlug;
  final int totalLessons;
  final int durationMinutes;
  final ColorCode courseColor;
  final String? videoUrl;
  final List<LmsModule> modules;

  const LmsCourse({
    required this.id,
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.categorySlug,
    this.totalLessons = 0,
    this.durationMinutes = 0,
    this.courseColor = ColorCode.blue,
    this.videoUrl,
    this.modules = const [],
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
