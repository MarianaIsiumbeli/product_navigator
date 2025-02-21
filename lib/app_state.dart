import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search {
  final String id;
  final String title;
  final String description;

  Search({
    required this.id,
    required this.title,
    required this.description,
  });
}

class AppState extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  User? _user;
  User? get user => _user;

  List<Search> _search = [];
  List<Search> get search => _search;

  AppState() {
    _init();
  }

  void _init() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      _loggedIn = user != null;
      if (_loggedIn) {
        _fetchSearch();
      } else {
        _search = [];
      }
      notifyListeners();
    });
    _loadThemePreference();
  }
 Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners(); 
  }

  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemePreference();
    notifyListeners();
  }

  Future<void> _fetchSearch() async {
    try {
      notifyListeners();
    } catch (e) {
      print('Error fetching search data: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error registering: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
      _loggedIn = false;

      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> updateUserProfile({required String displayName}) async {
    if (user != null) {
      try {
        await _firebaseAuth.currentUser!
            .updateProfile(displayName: displayName);
        _user = _firebaseAuth.currentUser;
        notifyListeners();
      } catch (e) {
        print('Error updating profile: $e');
      }
    }
  }

  Future<void> resetPassword() async {
    if (_user != null) {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: _user!.email!);
      } catch (e) {
        print('Error sending password reset email: $e');
      }
    }
  }

  Future<void> updatePassword(
      String newPassword, String confirmPassword) async {
    if (_user != null) {
      if (newPassword == confirmPassword) {
        try {
          await _user!.updatePassword(newPassword);
        } catch (e) {
          print('Error updating password: $e');
        }
      } else {
        print('Passwords do not match.');
      }
    }
  }
}
