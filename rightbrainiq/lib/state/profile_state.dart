import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class ProfileState extends ChangeNotifier {
  UserProfile _profile = const UserProfile();

  UserProfile get profile => _profile;

  void updateProfile(UserProfile profile) {
    _profile = profile;
    notifyListeners();
  }
}
