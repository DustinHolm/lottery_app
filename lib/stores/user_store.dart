import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lottery_app/controllers/auth_controller.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:nanoid/nanoid.dart';

enum Status { AUTHENTICATED, WAITING, UNAUTHENTICATED }

class UserStore extends ChangeNotifier {
  UserStore() {
    _init();
  }


  int _tickets = 0;
  User? _user;
  Status _status = Status.UNAUTHENTICATED;

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

  String get id => (_user == null) ? "GUEST-" + nanoid(3) : _user!.uid;
  String get name => (_user == null || _user!.displayName == null) ? "" : _user!.displayName!;
  AppUser get user => AppUser(id: id, name: name);

  _init() async {
    _user = await AuthController.getSignedInUser();
    if (_user != null) _status = Status.AUTHENTICATED;
  }

  Future<bool> signIn() async {
    _status = Status.WAITING;
    notifyListeners();

    _user = await AuthController.signInWithGoogle();

    if (_user != null) {
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
    _user = null;
    _status = Status.UNAUTHENTICATED;
    notifyListeners();
  }
}
