import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lottery_app/controllers/auth_controller.dart';
import 'package:lottery_app/models/address.dart';
import 'package:lottery_app/models/app_user.dart';

enum Status { AUTHENTICATED, WAITING, UNAUTHENTICATED }

class UserStore extends ChangeNotifier {
  AppUser? _appUser = AppUser(name: "AdminUser", address: Address());
  int _tickets = 0;
  User? _gUser;
  Status _status = Status.UNAUTHENTICATED;

  AppUser? get appUser => _appUser;

  set appUser(AppUser? user) {
    _appUser = user;
    notifyListeners();
  }

  int get tickets {
    if (_status == Status.AUTHENTICATED) {
      return _tickets;
    } else {
      return 0;
    }
  }

  set tickets(int tickets) {
    _tickets = tickets;
    notifyListeners();
  }

  void addTickets(int n) {
    _tickets += n;
    notifyListeners();
  }

  void removeTickets(int n) {
    _tickets -= n;
    notifyListeners();
  }

  Status get status => _status;

  set status(Status status) {
    _status = status;
    notifyListeners();
  }

  User? get gUser => _gUser;

  Future<bool> signIn() async {
    _status = Status.WAITING;
    notifyListeners();

    _gUser = await AuthController.signInWithGoogle();

    if (_gUser != null) {
      _status = Status.AUTHENTICATED;
      notifyListeners();
      return true;
    } else {
      _status = Status.UNAUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await AuthController.signOut();
    _gUser = null;
    _status = Status.UNAUTHENTICATED;
    notifyListeners();
  }
}
