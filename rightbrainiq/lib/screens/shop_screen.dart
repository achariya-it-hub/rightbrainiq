import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/product.dart';
import '../data/product_repository.dart';
import '../state/cart_state.dart';
import '../state/order_history_state.dart';
import '../widgets/product_image.dart';
import '../widgets/animated_price.dart';
import 'cart_screen.dart';

class ShopScreen extends StatefulWidget {
  final CartState cartState;
  final ValueChanged<Product>? onNavigateProduct;
  final OrderHistoryState? orderHistoryState;

  const ShopScreen({
    super.key,
    required this.cartState,
    this.onNavigateProduct,
    this.orderHistoryState,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

enum _SortOption { nameAZ, nameZA, priceLow, priceHigh }

class _ShopScreenState extends State<ShopScreen> {
  String _selectedCategory = 'All';
  final _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  List<Product> _allProducts = [];
  _SortOption _sortOption = _SortOption.nameAZ;
  int _cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _allProducts = ProductRepository.allProducts;
    _filteredProducts = _allProducts;
    _searchController.addListener(_onSearchChanged);
    widget.cartState.addListener(_onCartChanged);
    _cartItemCount = widget.cartState.itemCount;
  }

  @override
  void dispose() {
    _searchController.dispose();
    widget.cartState.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) {
      setState(() => _cartItemCount = widget.cartState.itemCount);
    }
  }

  void _onSearchChanged() {
    _filterProducts();
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (_selectedCategory == 'All') {
        _filteredProducts = _allProducts.where((p) =>
            p.name.toLowerCase().contains(query) ||
            p.category.toLowerCase().contains(query)).toList();
      } else {
        _filteredProducts = _allProducts.where((p) =>
            p.category == _selectedCategory &&
            (p.name.toLowerCase().contains(query) ||
                p.category.toLowerCase().contains(query))).toList();
      }
      _applySort();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterProducts();
    });
  }

  void _applySort() {
    switch (_sortOption) {
      case _SortOption.nameAZ:
        _filteredProducts.sort((a, b) => a.name.compareTo(b.name));
      case _SortOption.nameZA:
        _filteredProducts.sort((a, b) => b.name.compareTo(a.name));
      case _SortOption.priceLow:
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      case _SortOption.priceHigh:
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen(cartState: widget.cartState, orderHistoryState: widget.orderHistoryState ?? OrderHistoryState()))),
              ),
              if (_cartItemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_cartItemCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search flashcard packs...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => _selectCategory(cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: isSelected ? null : Border.all(color: AppColors.divider),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat == 'All' ? 'All' : cat,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredProducts.length} products',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                PopupMenuButton<_SortOption>(
                  onSelected: (option) {
                    setState(() {
                      _sortOption = option;
                      _applySort();
                    });
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(value: _SortOption.nameAZ, child: const Text('Name A-Z')),
                    PopupMenuItem(value: _SortOption.nameZA, child: const Text('Name Z-A')),
                    PopupMenuItem(value: _SortOption.priceLow, child: const Text('Price: Low to High')),
                    PopupMenuItem(value: _SortOption.priceHigh, child: const Text('Price: High to Low')),
                  ],
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sort, size: 18),
                      SizedBox(width: 4),
                      Text('Sort', style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 48, color: AppColors.textSecondary.withValues(alpha: 0.4)),
                        const SizedBox(height: 12),
                        Text('No products found', style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.6))),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) => _productThumbnail(_filteredProducts[index]),
                  ),
          ),
        ],
      ),
    );
  }

  List<String> get _categories {
    final cats = ProductRepository.categories.map((c) => c.name).toSet().toList();
    return ['All', ...cats];
  }

  Widget _productThumbnail(Product product) {
    final color = Color(product.color.hexValue);
    return GestureDetector(
      onTap: () => widget.onNavigateProduct?.call(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.06),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Hero(
                  tag: 'product_img_${product.id}',
                  child: ProductImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    color: color,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.6),
                        blurRadius: 4,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Column(
                  children: [
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedPrice(
                          price: product.price,
                          currency: product.currency,
                          cardCount: product.cardCount,
                          fontSize: 16,
                          color: color,
                          showPerCard: false,
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${product.cardCount}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
