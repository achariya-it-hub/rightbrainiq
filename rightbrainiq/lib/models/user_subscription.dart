class UserSubscription {
  final String courseId;
  final String courseTitle;
  final DateTime purchasedAt;
  final DateTime? expiresAt;
  final DateTime? completedAt;
  final double progress;
  final bool isActive;

  const UserSubscription({
    required this.courseId,
    required this.courseTitle,
    required this.purchasedAt,
    this.expiresAt,
    this.completedAt,
    this.progress = 0.0,
    this.isActive = true,
  });

  UserSubscription copyWith({
    String? courseId,
    String? courseTitle,
    DateTime? purchasedAt,
    DateTime? expiresAt,
    DateTime? completedAt,
    double? progress,
    bool? isActive,
  }) {
    return UserSubscription(
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      completedAt: completedAt ?? this.completedAt,
      progress: progress ?? this.progress,
      isActive: isActive ?? this.isActive,
    );
  }
}
