import 'lms_lesson.dart';

class LmsModule {
  final String id;
  final String title;
  final String description;
  final int lessonCount;
  final List<LmsLesson> lessons;

  const LmsModule({
    required this.id,
    required this.title,
    this.description = '',
    this.lessonCount = 0,
    this.lessons = const [],
  });
}
