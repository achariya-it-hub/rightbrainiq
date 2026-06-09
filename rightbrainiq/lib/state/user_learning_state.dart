import 'package:flutter/foundation.dart';
import '../models/user_subscription.dart';

class UserLearningState extends ChangeNotifier {
  List<UserSubscription> _subscriptions = [];
  final Map<String, Set<String>> _completedLessons = {};
  final Map<String, int> _cardsReviewed = {};

  List<UserSubscription> get subscriptions => List.unmodifiable(_subscriptions);

  List<UserSubscription> get activeSubscriptions =>
      _subscriptions.where((s) => s.isActive).toList();

  Set<String> getCompletedLessons(String courseId) =>
      _completedLessons[courseId] ?? {};

  int getCardsReviewed(String lessonId) => _cardsReviewed[lessonId] ?? 0;

  double getCourseProgress(String courseId) {
    final sub = _subscriptions.cast<UserSubscription?>().firstWhere(
          (s) => s?.courseId == courseId,
          orElse: () => null,
        );
    return sub?.progress ?? 0.0;
  }

  bool isSubscribed(String courseId) =>
      _subscriptions.any((s) => s.courseId == courseId && s.isActive);

  void addSubscription(UserSubscription subscription) {
    _subscriptions.add(subscription);
    notifyListeners();
  }

  void completeLesson(String courseId, String lessonId, int totalLessons) {
    _completedLessons[courseId] = {...(_completedLessons[courseId] ?? {}), lessonId};
    _updateProgress(courseId, totalLessons);
    notifyListeners();
  }

  void recordCardsReviewed(String lessonId, int count) {
    _cardsReviewed[lessonId] = (_cardsReviewed[lessonId] ?? 0) + count;
  }

  void _updateProgress(String courseId, int totalLessons) {
    final completed = _completedLessons[courseId]?.length ?? 0;
    final progress = totalLessons > 0 ? completed / totalLessons : 0.0;
    final idx = _subscriptions.indexWhere((s) => s.courseId == courseId);
    if (idx >= 0) {
      _subscriptions[idx] = _subscriptions[idx].copyWith(
        progress: double.parse(progress.toStringAsFixed(2)),
      );
    }
  }

  void initDemoSubscriptions() {
    if (_subscriptions.isNotEmpty) return;
    _subscriptions = [
      UserSubscription(
        courseId: 'lms-ss',
        courseTitle: 'Smart Start Cards',
        purchasedAt: DateTime(2026, 5, 15),
        progress: 0.35,
        isActive: true,
      ),
      UserSubscription(
        courseId: 'lms-jb',
        courseTitle: 'Jumbo Cards',
        purchasedAt: DateTime(2026, 5, 20),
        progress: 0.60,
        isActive: true,
      ),
      UserSubscription(
        courseId: 'lms-gk',
        courseTitle: 'GK Cards',
        purchasedAt: DateTime(2026, 4, 10),
        progress: 1.0,
        isActive: true,
        completedAt: DateTime(2026, 5, 28),
      ),
    ];

    _completedLessons['lms-ss'] = {
      'ss-lesson-flags',
      'ss-lesson-animals',
      'ss-lesson-fruits',
      'ss-lesson-veg',
      'ss-lesson-birds',
    };
    _completedLessons['lms-jb'] = {
      'jb-lesson-1',
      'jb-lesson-2',
      'jb-lesson-3',
      'jb-lesson-4',
      'jb-lesson-5',
      'jb-lesson-6',
    };

    notifyListeners();
  }
}
