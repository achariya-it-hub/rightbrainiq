class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;

  const UserProfile({
    this.name = 'Alex Johnson',
    this.email = 'alex.johnson@email.com',
    this.phone = '+91 98765 43210',
    this.avatarUrl = 'assets/images/logo.png',
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
