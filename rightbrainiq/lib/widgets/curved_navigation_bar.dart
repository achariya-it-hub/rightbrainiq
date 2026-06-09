import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CurvedNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CurvedNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF1A2A4A),
      shape: const CircularNotchedRectangle(),
      elevation: 12,
      shadowColor: Colors.black.withValues(alpha: 0.25),
      height: 64,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(0, Icons.home_outlined, Icons.home, 'Home'),
          _navItem(1, Icons.store_outlined, Icons.store, 'Shop'),
          const SizedBox(width: 48),
          _navItem(3, Icons.emoji_events_outlined, Icons.emoji_events, 'Rewards'),
          _navItem(4, Icons.person_outline, Icons.person, 'Profile'),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary.withValues(alpha: 0.9), AppColors.primaryDark],
                    )
                  : null,
              color: isSelected ? null : Colors.transparent,
              boxShadow: isSelected
                  ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.25), blurRadius: 6, offset: const Offset(0, 3))]
                  : null,
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.55),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}
