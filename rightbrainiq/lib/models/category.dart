class Category {
  final String name;
  final String slug;
  final int productCount;
  final String imageUrl;
  final String description;

  const Category({
    required this.name,
    required this.slug,
    required this.productCount,
    required this.imageUrl,
    this.description = '',
  });
}
