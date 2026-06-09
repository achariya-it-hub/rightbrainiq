import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/lms_course.dart';
import '../models/user_subscription.dart';
import '../widgets/product_image.dart';
import '../state/user_learning_state.dart';
import 'lesson_player_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final LmsCourse course;
  final UserLearningState learningState;
  final UserSubscription? subscription;

  const CourseDetailScreen({
    super.key,
    required this.course,
    required this.learningState,
    this.subscription,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late final Color _color;

  @override
  void initState() {
    super.initState();
    _color = Color(widget.course.courseColor.hexValue);
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final hasAccess = widget.subscription?.isActive ?? false;
    final progress = hasAccess ? (widget.subscription?.progress ?? 0.0) : 0.0;
    final completedLessons = widget.learningState.getCompletedLessons(course.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ProductImage(imageUrl: course.imageUrl, fit: BoxFit.cover, color: _color),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, _color.withValues(alpha: 0.85)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text(course.subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _statChip(Icons.menu_book, '${course.totalLessons} Lessons', _color),
                      const SizedBox(width: 12),
                      _statChip(Icons.timer_outlined, '${course.durationMinutes} min', _color),
                      const Spacer(),
                      if (hasAccess)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                          child: const Text('Active', style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w700)),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                          child: const Text('Subscribe', style: TextStyle(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w700)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(course.description, style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.8), fontSize: 13, height: 1.5)),
                  if (course.videoUrl != null) ...[
                    const SizedBox(height: 20),
                    _buildVideoSection(course.videoUrl!, _color),
                  ],
                  if (hasAccess) ...[
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppColors.divider,
                        valueColor: AlwaysStoppedAnimation<Color>(_color),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('${(progress * 100).round()}% complete', style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.7))),
                  ],
                  const SizedBox(height: 24),
                  const Text('Course Content', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('${course.modules.length} modules', style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.6))),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final module = course.modules[index];
                final allCompleted = module.lessons.every((l) => completedLessons.contains(l.id));
                final someCompleted = module.lessons.any((l) => completedLessons.contains(l.id));

                return Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: allCompleted ? Border.all(color: AppColors.success.withValues(alpha: 0.3)) : null,
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: allCompleted
                              ? AppColors.success.withValues(alpha: 0.1)
                              : someCompleted
                                  ? _color.withValues(alpha: 0.1)
                                  : AppColors.divider.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          allCompleted ? Icons.check_circle : someCompleted ? Icons.play_circle_outline : Icons.lock_outline,
                          size: 16,
                          color: allCompleted ? AppColors.success : someCompleted ? _color : AppColors.textSecondary,
                        ),
                      ),
                      title: Text(
                        module.title,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${module.lessons.length} ${module.lessons.length == 1 ? 'lesson' : 'lessons'}${module.description.isNotEmpty ? ' • ${module.description}' : ''}',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.6)),
                      ),
                      children: module.lessons.map((lesson) {
                        final isCompleted = completedLessons.contains(lesson.id);
                        return ListTile(
                          contentPadding: const EdgeInsets.only(left: 64, right: 16),
                          leading: Icon(
                            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                            size: 18,
                            color: isCompleted ? AppColors.success : AppColors.textSecondary.withValues(alpha: 0.4),
                          ),
                          title: Text(
                            lesson.title,
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isCompleted ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.onSurface),
                          ),
                          trailing: hasAccess
                              ? Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isCompleted ? AppColors.success.withValues(alpha: 0.1) : _color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${lesson.cardCount} cards',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isCompleted ? AppColors.success : _color),
                                  ),
                                )
                              : const Icon(Icons.lock_outline, size: 16, color: AppColors.textSecondary),
                          onTap: hasAccess
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LessonPlayerScreen(
                                        lesson: lesson,
                                        courseColor: widget.course.courseColor,
                                        onComplete: () {
                                          widget.learningState.completeLesson(
                                            widget.course.id,
                                            lesson.id,
                                            widget.course.totalLessons,
                                          );
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                }
                              : null,
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              childCount: course.modules.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Widget _buildVideoSection(String videoUrl, Color color) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.tryParse(videoUrl);
        if (uri != null && await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.7), color.withValues(alpha: 0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow_rounded, size: 36, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'How to Use the Flashcards',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Watch tutorial video',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
