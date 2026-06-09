import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthService {
  static final AuthService instance = AuthService._();
  AuthService._();

  SupabaseClient get _client => SupabaseService.instance.client;

  User? get currentUser => _client.auth.currentUser;
  bool get isSignedIn => currentUser != null;

  Future<AuthResponse> signUp(String email, String password) async {
    final response = await _client.auth.signUp(email: email, password: password);
    if (response.user != null) {
      await _client.from('profiles').insert({
        'id': response.user!.id,
        'email': email,
        'name': email.split('@').first,
      });
    }
    return response;
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
