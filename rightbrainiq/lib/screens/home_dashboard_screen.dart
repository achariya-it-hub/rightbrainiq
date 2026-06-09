import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../data/product_repository.dart';
import '../state/cart_state.dart';
import '../state/order_history_state.dart';
import '../widgets/product_image.dart';
import '../widgets/animated_price.dart';
import 'cart_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  final CartState? cartState;
  final ValueChanged<Product>? onNavigateProduct;
  final VoidCallback? onNavigateToShop;
  final OrderHistoryState? orderHistoryState;

  const HomeDashboardScreen({
    super.key,
    this.cartState,
    this.onNavigateProduct,
    this.onNavigateToShop,
    this.orderHistoryState,
  });

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  final _bannerController = PageController();
  late final Timer _bannerTimer;
  int _bannerIndex = 0;
  int _cartItemCount = 0;

  final _banners = <({String title, String subtitle, Color color, String imageUrl, IconData icon})>[
    (title: 'Big Sale', subtitle: 'Up to 40% Off Smart Start Cards', color: AppColors.accentOrange, imageUrl: ProductRepository.smartStartCards[0].imageUrl, icon: Icons.local_fire_department),
    (title: 'New Arrivals', subtitle: 'Explore GEO Cards Collection', color: AppColors.primary, imageUrl: ProductRepository.geoCards[0].imageUrl, icon: Icons.explore),
    (title: 'Combo Offer', subtitle: 'Buy 3 Jumbo Packs Get 1 Free', color: AppColors.secondary, imageUrl: ProductRepository.jumboCards[0].imageUrl, icon: Icons.card_giftcard),
    (title: 'Flash Sale', subtitle: 'Mini Globe Cards at ₹299 Only', color: AppColors.success, imageUrl: ProductRepository.miniGlobeCards[0].imageUrl, icon: Icons.bolt),
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_bannerController.hasClients) {
        final next = (_bannerIndex + 1) % _banners.length;
        _bannerController.animateToPage(next, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
    widget.cartState?.addListener(_onCartChanged);
    _cartItemCount = widget.cartState?.itemCount ?? 0;
  }

  @override
  void dispose() {
    _bannerTimer.cancel();
    _bannerController.dispose();
    widget.cartState?.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) {
      setState(() => _cartItemCount = widget.cartState?.itemCount ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final featured = ProductRepository.allProducts.take(6).toList();
    final categories = ProductRepository.categories;
    final popular = ProductRepository.jumboCards;
    final offerProducts = [
      ...ProductRepository.smartStartCards.take(4),
      ...ProductRepository.connectCards.take(2),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('RightBrainIQ'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen(cartState: widget.cartState!, orderHistoryState: widget.orderHistoryState ?? OrderHistoryState()))),
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
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(milliseconds: 500)),
        child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                onTap: () => widget.onNavigateToShop?.call(),
                decoration: InputDecoration(
                  hintText: 'Search flashcard packs...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            _buildBannerCarousel(),
            const SizedBox(height: 20),
            _buildOfferZone(context, offerProducts),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Shop by Category', 'See All'),
            const SizedBox(height: 12),
            _buildCategoryRow(context, categories),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Featured Products', 'See All'),
            const SizedBox(height: 12),
            _buildProductRow(context, featured, height: 280),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Bestsellers', 'See All'),
            const SizedBox(height: 12),
            _buildProductRow(context, popular, height: 280),
            const SizedBox(height: 20),
            _buildBottomBanner(context),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return SizedBox(
      height: 180,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _bannerController,
              onPageChanged: (i) => setState(() => _bannerIndex = i),
              itemCount: _banners.length,
              itemBuilder: (context, index) {
                final b = _banners[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [b.color, b.color.withValues(alpha: 0.75)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(color: b.color.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 8)),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Icon(b.icon, size: 180, color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 3))],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ProductImage(imageUrl: b.imageUrl, fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                              child: Text(b.title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                            ),
                            const SizedBox(height: 10),
                            Text(b.subtitle, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, height: 1.2), maxLines: 2),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('Shop Now', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _banners.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _bannerIndex == i ? 22 : 7,
                height: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _bannerIndex == i ? AppColors.primary : AppColors.divider,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferZone(BuildContext context, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.accentOrange, AppColors.accent]),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_offer, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text('OFFER ZONE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text('Deals & Discounts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(
                onPressed: () => widget.onNavigateToShop?.call(),
                child: const Text('View All', style: TextStyle(color: AppColors.accentOrange, fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _offerCard(context, products[index]),
          ),
        ),
      ],
    );
  }

  Widget _offerCard(BuildContext context, Product product) {
    final color = Color(product.color.hexValue);
    final discounts = [15, 20, 25, 30, 10, 40];
    final disc = discounts[product.id.hashCode % discounts.length];
    return GestureDetector(
      onTap: () => widget.onNavigateProduct?.call(product),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ProductImage(imageUrl: product.imageUrl, fit: BoxFit.cover, color: color),
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [AppColors.accentOrange, AppColors.accent]),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('-$disc%', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text('${product.cardCount} cards', style: TextStyle(fontSize: 9, color: AppColors.textSecondary.withValues(alpha: 0.5))),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${product.currency}${(product.price * (100 - disc) / 100).round()}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: color,
                            shadows: [
                              Shadow(offset: const Offset(0, 1), blurRadius: 2, color: Colors.black.withValues(alpha: 0.15)),
                              Shadow(offset: const Offset(-1, -1), blurRadius: 1, color: Colors.white.withValues(alpha: 0.5)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('${product.currency}${product.price}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary.withValues(alpha: 0.4), decoration: TextDecoration.lineThrough)),
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

  Widget _buildSectionHeader(BuildContext context, String title, String actionLabel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          TextButton(
            onPressed: () => widget.onNavigateToShop?.call(),
            child: Text(actionLabel, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context, List<Category> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _categoryChip(context, categories[index]),
      ),
    );
  }

  Widget _buildProductRow(BuildContext context, List<Product> products, {required double height}) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) => _productCard(context, products[index]),
      ),
    );
  }

  Widget _buildBottomBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [AppColors.primaryLight, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Free Shipping', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('on orders above ₹999', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: const Text('Order Now', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.local_shipping, size: 80, color: Colors.white.withValues(alpha: 0.15)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryChip(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () => widget.onNavigateToShop?.call(),
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  category.imageUrl,
                  fit: BoxFit.cover,
                  width: 50,
                  errorBuilder: (_, _, _) => Icon(Icons.category, size: 24, color: AppColors.primary.withValues(alpha: 0.5)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category.name.length > 12 ? '${category.name.substring(0, 10)}..' : category.name,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _productCard(BuildContext context, Product product) {
    final color = Color(product.color.hexValue);
    return GestureDetector(
      onTap: () => widget.onNavigateProduct?.call(product),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Hero(
                  tag: 'product_img_${product.id}',
                  child: ProductImage(imageUrl: product.imageUrl, fit: BoxFit.cover, color: color),
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
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
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
                          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                          child: Text('${product.cardCount}', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: color)),
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
