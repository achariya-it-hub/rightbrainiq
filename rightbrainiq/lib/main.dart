import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/rewards_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail_screen.dart';
import 'models/product.dart';
import 'state/user_learning_state.dart';
import 'state/cart_state.dart';
import 'state/profile_state.dart';
import 'state/order_history_state.dart';
import 'state/theme_state.dart';
import 'widgets/curved_navigation_bar.dart';
import 'services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SupabaseService.instance.initialize();
  } catch (_) {
    // Supabase not configured yet — app works with in-memory data
  }
  runApp(const RightBrainIQApp());
}

class RightBrainIQApp extends StatefulWidget {
  const RightBrainIQApp({super.key});

  @override
  State<RightBrainIQApp> createState() => _RightBrainIQAppState();
}

class _RightBrainIQAppState extends State<RightBrainIQApp> {
  @override
  void initState() {
    super.initState();
    ThemeState.instance.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    ThemeState.instance.removeListener(_onThemeChanged);
    ThemeState.instance.dispose();
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RightBrainIQ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeState.instance.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final _learningState = UserLearningState();
  final _cartState = CartState();
  final _profileState = ProfileState();
  final _orderHistoryState = OrderHistoryState();

  @override
  void initState() {
    super.initState();
    _learningState.initDemoSubscriptions();
  }

  @override
  void dispose() {
    _learningState.dispose();
    _cartState.dispose();
    _profileState.dispose();
    _orderHistoryState.dispose();
    super.dispose();
  }

  void _navigateToTab(int index) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    setState(() => _currentIndex = index);
  }

  void _openCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CartScreen(
          cartState: _cartState,
          profileState: _profileState,
          orderHistoryState: _orderHistoryState,
        ),
      ),
    );
  }

  void _openProduct(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductDetailScreen(
          product: product,
          cartState: _cartState,
          onNavigateCart: _openCart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
              HomeDashboardScreen(
                cartState: _cartState,
                orderHistoryState: _orderHistoryState,
                onNavigateProduct: _openProduct,
                onNavigateToShop: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  setState(() => _currentIndex = 1);
                },
              ),
              ShopScreen(
                cartState: _cartState,
                orderHistoryState: _orderHistoryState,
                onNavigateProduct: _openProduct,
              ),
          LearnScreen(learningState: _learningState),
          RewardsScreen(
            learningState: _learningState,
            profileState: _profileState,
          ),
          ProfileScreen(
            learningState: _learningState,
            profileState: _profileState,
            orderHistoryState: _orderHistoryState,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToTab(2),
        elevation: 4,
        highlightElevation: 8,
        shape: const CircleBorder(),
        backgroundColor: _currentIndex == 2 ? AppColors.primaryLight : AppColors.primary,
        child: const Icon(Icons.menu_book, size: 24, color: Colors.white),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateToTab,
      ),
    );
  }
}
