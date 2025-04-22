import 'package:desafio_capyba/core/exceptions/auth_exception.dart';
import 'package:desafio_capyba/shared/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  static final _auth = FirebaseAuth.instance;

  late UserModel _userModel;

  UserModel get userModel => _userModel;

  bool get isAuth {
    return _auth.currentUser != null;
  }

  String? get userId {
    return isAuth ? _auth.currentUser!.uid : null;
  }

  bool get isEmailVerified {
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<void> loadUserModel() async {
    if (_auth.currentUser != null) {
      final user = _auth.currentUser!;
      _userModel = await UserModel.empty().copyWith(id: user.uid).getItem();
      notifyListeners();
    }
  }

  Future<void> _authenticate(
      String email, String password, bool isLogin) async {
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      final user = _auth.currentUser;
      if (user != null) {
        _userModel = await UserModel.empty().copyWith(id: user.uid).getItem();
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<void> reloadAuth() async {
    try {
      await _auth.currentUser?.reload();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signup(String email, String password) async {
    await _authenticate(email, password, false);
  }

  Future<void> login(String email, String password) async {
    await _authenticate(email, password, true);
  }

  Future<void> logout() async {
    _userModel = UserModel.empty();
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveRestrictedItem(String itemId) async {
    try {
      if (_userModel.restrictedItems.contains(itemId)) return;

      final updatedUser = await _userModel.copyWith(
        restrictedItems: [..._userModel.restrictedItems, itemId],
      ).save();

      _userModel = updatedUser;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
