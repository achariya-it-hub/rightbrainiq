import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/lms_course.dart';
import '../models/user_subscription.dart';
import '../data/lms_repository.dart';
import '../widgets/product_image.dart';
import '../state/user_learning_state.dart';
import 'course_detail_screen.dart';

class LearnScreen extends StatefulWidget {
  final UserLearningState learningState;

  const LearnScreen({super.key, required this.learningState});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    final state = widget.learningState;
    final courses = LmsRepository.allCourses;
    final subscriptions = state.activeSubscriptions;
    final subscribedIds = subscriptions.map((s) => s.courseId).toSet();

    return ListenableBuilder(
      listenable: widget.learningState,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('My Learning'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search courses...',
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
              if (subscriptions.isNotEmpty) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text('My Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                        child: Text('${subscriptions.length}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                ...subscriptions.map((sub) {
                  final course = LmsRepository.getCourseById(sub.courseId);
                  if (course == null) return const SizedBox();
                  return _subscriptionCard(context, course, sub);
                }),
                const SizedBox(height: 24),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Course Catalog', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    Text('${courses.length} courses', style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.6))),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ...courses.map((course) {
                final isSubscribed = subscribedIds.contains(course.id);
                final sub = isSubscribed
                    ? subscriptions.firstWhere((s) => s.courseId == course.id)
                    : null;
                return _catalogCard(context, course, isSubscribed, sub);
              }),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subscriptionCard(BuildContext context, LmsCourse course, UserSubscription sub) {
    final color = Color(course.courseColor.hexValue);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailScreen(
              course: course,
              learningState: widget.learningState,
              subscription: sub,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ProductImage(imageUrl: course.imageUrl, fit: BoxFit.cover, color: color),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, color.withValues(alpha: 0.85)],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(course.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 2),
                            Text(course.subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _statChip(Icons.menu_book, '${course.totalLessons} lessons', color),
                        const SizedBox(width: 10),
                        _statChip(Icons.timer_outlined, '${course.durationMinutes} min', color),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                          child: Text('${(sub.progress * 100).round()}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: sub.progress,
                        backgroundColor: AppColors.divider,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 6,
                     ),
                    ),
                    const SizedBox(height: 4),
                    Text('Continue where you left off', style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.6))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _catalogCard(BuildContext context, LmsCourse course, bool isSubscribed, UserSubscription? sub) {
    final color = Color(course.courseColor.hexValue);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailScreen(
              course: course,
              learningState: widget.learningState,
              subscription: sub,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: ProductImage(imageUrl: course.imageUrl, fit: BoxFit.cover, color: color),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text('${course.totalLessons} lessons • ${course.durationMinutes} min', style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.7))),
                    if (isSubscribed && sub != null) ...[
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: sub.progress,
                          backgroundColor: AppColors.divider,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: isSubscribed ? color.withValues(alpha: 0.1) : AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isSubscribed ? 'Resume' : 'Explore',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isSubscribed ? color : Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statChip(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color.withValues(alpha: 0.7)),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.7), fontWeight: FontWeight.w500)),
      ],
    );
  }
}
