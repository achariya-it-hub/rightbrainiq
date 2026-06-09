import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/user_learning_state.dart';
import '../state/profile_state.dart';
import '../models/user_subscription.dart';

class RewardsScreen extends StatelessWidget {
  final UserLearningState learningState;
  final ProfileState? profileState;

  const RewardsScreen({super.key, required this.learningState, this.profileState});

  List<UserSubscription> get _completedCourses =>
      learningState.subscriptions.where((s) => s.progress >= 1.0).toList();

  static final _offers = [
    _Offer('Smart Start Combo', 'Buy 2 Smart Start packs & get 1 free', '20% OFF', AppColors.primary, Icons.card_giftcard),
    _Offer('Jumbo Bundle', 'All Jumbo Cards at ₹299 each', 'FLAT ₹100 OFF', AppColors.accentOrange, Icons.discount),
    _Offer('Free Shipping', 'On orders above ₹999', 'FREE', AppColors.success, Icons.local_shipping),
    _Offer('GEO Cards Deal', 'Complete GEO set at ₹999 only', '40% OFF', AppColors.secondary, Icons.explore),
  ];

  static final _badges = [
    _Badge('Quick Starter', 'Study your first 10 cards', Icons.rocket_launch, const Color(0xFFFF6B6B)),
    _Badge('Streak Master', '7-day study streak', Icons.local_fire_department, const Color(0xFFFFB74D)),
    _Badge('Scholar', 'Master 50 cards', Icons.school, AppColors.primary),
    _Badge('Polyglot', 'Study 3 language packs', Icons.translate, const Color(0xFF4ECDC4)),
    _Badge('Speed Demon', 'Answer 20 cards in 5 min', Icons.bolt, const Color(0xFFE040FB)),
    _Badge('Dedicated', 'Study 30 days total', Icons.timer, const Color(0xFF2196F3)),
  ];

  static final _leaderboard = [
    _LeaderboardEntry('Alex', 12850, true, 'assets/images/logo.png'),
    _LeaderboardEntry('Sarah', 11200, false, null),
    _LeaderboardEntry('Mike', 9800, false, null),
    _LeaderboardEntry('Emma', 8200, false, null),
    _LeaderboardEntry('James', 7100, false, null),
  ];

  void _showCertificate(BuildContext context, UserSubscription sub) {
    final userName = profileState?.profile.name ?? 'Learner';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.verified, color: AppColors.accent, size: 36),
              ),
              const SizedBox(height: 16),
              const Text('Certificate of Completion', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text('This certifies that', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)),
              const SizedBox(height: 8),
              Text('has successfully completed', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Text(sub.courseTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Completed on ${sub.completedAt != null ? '${sub.completedAt!.day}/${sub.completedAt!.month}/${sub.completedAt!.year}' : 'N/A'}',
                  style: const TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events, size: 16, color: AppColors.accent.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Text('RightBrainIQ', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.textSecondary.withValues(alpha: 0.1),
              foregroundColor: AppColors.textSecondary,
              fixedSize: const Size(130, 42),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Certificate downloaded!'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.download, size: 18),
            label: const Text('Download'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              fixedSize: const Size(130, 42),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCourses = _completedCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [AppColors.accent, AppColors.accentOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.emoji_events, color: Colors.white, size: 40),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total XP Earned', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text('2,450 XP', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('Level 8', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Column(
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.white, size: 28),
                      SizedBox(height: 2),
                      Text('5', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                      Text('day streak', style: TextStyle(color: Colors.white70, fontSize: 9)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Customized Offers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _offers.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) => _offerCard(_offers[index]),
              ),
            ),
            const SizedBox(height: 24),
            if (completedCourses.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Certificates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < completedCourses.length; i++) ...[
                          if (i > 0) const SizedBox(width: 12),
                          _certificateCard(context, completedCourses[i]),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _badges.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) => _badgeCard(context, _badges[index]),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Leaderboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: _leaderboard.asMap().entries.map((entry) {
                  return _leaderboardRow(context, entry.key, entry.value);
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _certificateCard(BuildContext context, UserSubscription sub) {
    return GestureDetector(
      onTap: () => _showCertificate(context, sub),
      child: Container(
        width: 230,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, AppColors.primary.withValues(alpha: 0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.verified, color: AppColors.accent, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              sub.courseTitle,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              sub.completedAt != null
                  ? 'Completed ${sub.completedAt!.day}/${sub.completedAt!.month}/${sub.completedAt!.year}'
                  : 'Completed',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download, size: 14, color: AppColors.primary),
                  SizedBox(width: 4),
                  Text('Download', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _offerCard(_Offer offer) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: offer.color.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: offer.color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: offer.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(offer.icon, color: offer.color, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [offer.color, offer.color.withValues(alpha: 0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  offer.discount,
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            offer.title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            offer.description,
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary.withValues(alpha: 0.7)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: offer.color,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Claim', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badgeCard(BuildContext context, _Badge badge) {
    final isUnlocked = badge.title != 'Speed Demon';
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: isUnlocked ? 1 : 0.35,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: badge.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(badge.icon, color: badge.color, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            badge.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: isUnlocked ? Theme.of(context).colorScheme.onSurface : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            badge.description,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _leaderboardRow(BuildContext context, int index, _LeaderboardEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: entry.isCurrentUser ? AppColors.primary.withValues(alpha: 0.06) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: entry.isCurrentUser
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.2))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: index < 3 ? AppColors.accent : AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 16,
            backgroundImage: entry.imageAsset != null
                ? AssetImage(entry.imageAsset!)
                : null,
            child: entry.imageAsset == null
                ? Text(
                    entry.name[0],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              entry.name,
              style: TextStyle(
                fontWeight: entry.isCurrentUser ? FontWeight.w700 : FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ),
          Row(
            children: [
              if (index < 3)
                Icon(
                  [Icons.emoji_events, Icons.emoji_events, Icons.emoji_events][index],
                  size: 16,
                  color: [const Color(0xFFFFD700), const Color(0xFFC0C0C0), const Color(0xFFCD7F32)][index],
                ),
              const SizedBox(width: 4),
              Text(
                '${entry.xp} XP',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: entry.isCurrentUser ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Offer {
  final String title;
  final String description;
  final String discount;
  final Color color;
  final IconData icon;

  const _Offer(this.title, this.description, this.discount, this.color, this.icon);
}

class _Badge {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _Badge(this.title, this.description, this.icon, this.color);
}

class _LeaderboardEntry {
  final String name;
  final int xp;
  final bool isCurrentUser;
  final String? imageAsset;

  const _LeaderboardEntry(this.name, this.xp, this.isCurrentUser, this.imageAsset);
}
