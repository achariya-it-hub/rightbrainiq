import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/lms_course.dart';
import '../models/lms_lesson.dart';

class LessonPlayerScreen extends StatefulWidget {
  final LmsLesson lesson;
  final ColorCode courseColor;
  final VoidCallback onComplete;

  const LessonPlayerScreen({
    super.key,
    required this.lesson,
    this.courseColor = ColorCode.blue,
    required this.onComplete,
  });

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  bool _isFlipped = false;
  int _currentIndex = 0;
  final Set<int> _knownCards = {};

  Color get _color => Color(widget.courseColor.hexValue);

  List<FlashcardData> get _cards => widget.lesson.cards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_currentIndex + 1}/${_cards.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  '${_knownCards.length} known',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.success.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / _cards.length,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(_color),
                minHeight: 5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isFlipped = !_isFlipped),
              onHorizontalDragEnd: (details) {
                if (_isFlipped && details.primaryVelocity != null && details.primaryVelocity! < -100 && _currentIndex < _cards.length - 1) {
                  _nextCard(_knownCards.contains(_currentIndex));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(_isFlipped),
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: _isFlipped
                          ? LinearGradient(
                              colors: [_color, _color.withValues(alpha: 0.7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: _isFlipped ? null : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: _color.withValues(alpha: 0.1), blurRadius: 24, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isFlipped ? Icons.lightbulb_outline : Icons.help_outline,
                          size: 36,
                          color: _isFlipped ? Colors.white70 : _color.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _isFlipped ? _cards[_currentIndex].answer : _cards[_currentIndex].question,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _isFlipped ? Colors.white : Theme.of(context).colorScheme.onSurface,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: (_isFlipped ? Colors.white : _color).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _isFlipped ? 'Tap to see question' : 'Tap to reveal answer',
                            style: TextStyle(
                              fontSize: 12,
                              color: _isFlipped ? Colors.white70 : _color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_isFlipped)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _actionButton(
                      icon: Icons.close,
                      label: 'Still Learning',
                      color: AppColors.error,
                      onTap: () => _nextCard(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _actionButton(
                      icon: Icons.check,
                      label: 'Got It!',
                      color: AppColors.success,
                      onTap: () => _nextCard(true),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _nextCard(bool known) {
    if (_currentIndex < _cards.length - 1) {
      setState(() {
        if (known) _knownCards.add(_currentIndex);
        _currentIndex++;
        _isFlipped = false;
      });
    } else {
      if (known) _knownCards.add(_currentIndex);
      widget.onComplete();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lesson completed!'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
