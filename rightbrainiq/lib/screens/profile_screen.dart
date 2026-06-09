import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../state/user_learning_state.dart';
import '../state/profile_state.dart';
import '../state/theme_state.dart';
import '../state/order_history_state.dart';
import 'splash_screen.dart';
import 'order_history_screen.dart';

class ProfileScreen extends StatefulWidget {
  final UserLearningState learningState;
  final ProfileState profileState;
  final OrderHistoryState orderHistoryState;

  const ProfileScreen({
    super.key,
    required this.learningState,
    required this.profileState,
    required this.orderHistoryState,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const SplashScreen()),
                (_) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showEditProfile() {
    final p = widget.profileState.profile;
    final nameCtrl = TextEditingController(text: p.name);
    final emailCtrl = TextEditingController(text: p.email);
    final phoneCtrl = TextEditingController(text: p.phone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            _editField(nameCtrl, 'Full Name', Icons.person_outline),
            const SizedBox(height: 12),
            _editField(emailCtrl, 'Email', Icons.email_outlined),
            const SizedBox(height: 12),
            _editField(phoneCtrl, 'Phone', Icons.phone_outlined),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.profileState.updateProfile(p.copyWith(
                    name: nameCtrl.text.trim(),
                    email: emailCtrl.text.trim(),
                    phone: phoneCtrl.text.trim(),
                  ));
                  Navigator.pop(ctx);
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editField(TextEditingController ctrl, String label, IconData icon) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  void _showHelpCenter() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Help Center', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reach out to us anytime:', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            SizedBox(height: 16),
            _ContactRow(Icons.email_outlined, 'info@rightbrainiq.com'),
            SizedBox(height: 10),
            _ContactRow(Icons.phone_outlined, '+91 96293 86639'),
            SizedBox(height: 10),
            _ContactRow(Icons.phone_outlined, '+91 93444 51222'),
            SizedBox(height: 10),
            _ContactRow(Icons.location_on_outlined, 'Chennai, India'),
            SizedBox(height: 16),
            Text('A Unit of Miway Teaching Aids Pvt. Ltd.', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showAboutUs() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.primary),
            SizedBox(width: 8),
            Text('About Us', style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'At Right Brain IQ, we believe that learning should be fun, engaging, and brain-boosting.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Text(
                'Our mission is to make early childhood education more interactive by providing high-quality flash cards, puzzles, and brain-development tools that spark curiosity and unlock your child\'s true potential.',
                style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
              ),
              SizedBox(height: 12),
              Text(
                'Every product in our store is carefully designed to not just entertain, but to enhance IQ, EQ, and overall brain development. From toddlers to young learners, our tools are crafted to create a playful yet powerful learning experience, perfect for home learning, homeschooling, and classroom use.',
                style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 12),
              Text(
                'A Unit of Miway Teaching Aids Pvt. Ltd. Pondicherry',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
          TextButton.icon(
            onPressed: () => _launchUrl('https://rightbrainiq.com/about-us/'),
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('Visit Website'),
          ),
        ],
      ),
    );
  }

  void _showSubscriptions() {
    final subs = widget.learningState.activeSubscriptions;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Active Subscriptions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            if (subs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text('No active subscriptions', style: TextStyle(color: AppColors.textSecondary)),
                ),
              )
            else
              ...subs.map((s) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.card_membership, color: AppColors.primary, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.courseTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: s.progress,
                                  minHeight: 6,
                                  backgroundColor: AppColors.divider,
                                  valueColor: const AlwaysStoppedAnimation(AppColors.success),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text('${(s.progress * 100).round()}% complete', style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.7))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([widget.profileState, ThemeState.instance]),
      builder: (context, _) {
        final profile = widget.profileState.profile;
        final subs = widget.learningState.activeSubscriptions;
        return Scaffold(
          appBar: AppBar(
            title: Text(profile.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _showEditProfile,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundImage: AssetImage(profile.avatarUrl),
                        backgroundColor: AppColors.primaryLight,
                        child: const Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary.withValues(alpha: 0.8)),
                ),
                const SizedBox(height: 20),
                _statsRow(),
                const SizedBox(height: 24),
                _section('Account', [
                  _menuItem(Icons.person_outline, 'Personal Info', _showEditProfile),
                  _menuItem(Icons.card_membership_outlined, 'My Subscriptions', _showSubscriptions, subtitle: '${subs.length} active'),
                  _menuItem(Icons.receipt_long_outlined, 'My Orders', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => OrderHistoryScreen(orderHistoryState: widget.orderHistoryState)));
                  }, subtitle: '${widget.orderHistoryState.orders.length}'),
                  _menuItem(Icons.history, 'Study History', () {}),
                ]),
                const SizedBox(height: 20),
                _section('Preferences', [
                  _menuItem(Icons.notifications_outlined, 'Notifications', () {}),
                  _menuItem(Icons.dark_mode_outlined, 'Dark Mode', () {}, trailing: Switch(
                    value: ThemeState.instance.isDark,
                    onChanged: (v) => ThemeState.instance.setDark(v),
                    activeTrackColor: AppColors.primaryLight,
                  )),
                  _menuItem(Icons.language_outlined, 'Language', () {}, subtitle: 'English'),
                ]),
                const SizedBox(height: 20),
                _section('Support', [
                  _menuItem(Icons.help_outline, 'Help Center', _showHelpCenter),
                  _menuItem(Icons.info_outline, 'About Us', _showAboutUs),
                ]),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _confirmSignOut,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
            ),
          );
        },
      );
  }

  Widget _statsRow() {
    final subs = widget.learningState.activeSubscriptions;
    final totalCards = subs.fold<int>(0, (sum, s) {
      return sum + widget.learningState.getCompletedLessons(s.courseId).length * 10;
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('Packs', '${subs.length}'),
          _divider(),
          _statItem('Cards', '$totalCards'),
          _divider(),
          _statItem('XP', '2,450'),
          _divider(),
          _statItem('Streak', '5'),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.7)),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 32, color: AppColors.divider);
  }

  Widget _section(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ...items,
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap, {String? subtitle, Widget? trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.7)),
              )
            : null,
        trailing: trailing ?? const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}
