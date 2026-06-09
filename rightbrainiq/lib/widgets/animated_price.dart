import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedPrice extends StatefulWidget {
  final double price;
  final String currency;
  final int? cardCount;
  final double fontSize;
  final Color? color;
  final bool showPerCard;

  const AnimatedPrice({
    super.key,
    required this.price,
    this.currency = '₹',
    this.cardCount,
    this.fontSize = 28,
    this.color,
    this.showPerCard = true,
  });

  @override
  State<AnimatedPrice> createState() => _AnimatedPriceState();
}

class _AnimatedPriceState extends State<AnimatedPrice> with SingleTickerProviderStateMixin {
  double _displayedPrice = 0;
  bool _showPerCard = false;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnim;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bounceAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOutBack),
    );
    _animatePrice();
  }

  @override
  void didUpdateWidget(AnimatedPrice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.price != widget.price) {
      _displayedPrice = 0;
      _animatePrice();
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _animatePrice() {
    final stepCount = 20;
    final increment = widget.price / stepCount;
    int step = 0;
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 30));
      if (!mounted) return false;
      step++;
      final newVal = (increment * step).clamp(0.0, widget.price);
      if (step >= stepCount) {
        setState(() => _displayedPrice = widget.price);
        return false;
      }
      setState(() => _displayedPrice = newVal);
      return true;
    });
  }

  void _onTap() {
    final cardCount = widget.cardCount;
    if (!widget.showPerCard || cardCount == null || cardCount == 0) return;
    _bounceController.forward().then((_) => _bounceController.reverse());
    setState(() => _showPerCard = !_showPerCard);
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;
    final scheme = Theme.of(context).colorScheme;
    final cardCount = widget.cardCount;

    if (_showPerCard && cardCount != null && cardCount > 0) {
      final perCard = widget.price / cardCount;
      return GestureDetector(
        onTap: _onTap,
        child: ScaleTransition(
          scale: _bounceAnim,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.currency}${perCard.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w800,
                  color: color,
                  shadows: [
                    Shadow(offset: const Offset(0, 1), blurRadius: 3, color: Colors.black.withValues(alpha: 0.15)),
                    Shadow(offset: const Offset(-1, -1), blurRadius: 1, color: Colors.white.withValues(alpha: 0.5)),
                  ],
                ),
              ),
              Text(
                'per card',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _bounceAnim,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.currency}${_displayedPrice.round()}',
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w800,
                color: color,
                shadows: [
                  Shadow(offset: const Offset(0, 1), blurRadius: 3, color: Colors.black.withValues(alpha: 0.15)),
                  Shadow(offset: const Offset(-1, -1), blurRadius: 1, color: Colors.white.withValues(alpha: 0.5)),
                ],
              ),
            ),
            if (widget.showPerCard && cardCount != null && cardCount > 0)
              Text(
                'tap for per card',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurface.withValues(alpha: 0.35),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
