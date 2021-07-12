import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lottery_app/controllers/auth_controller.dart';
import 'package:lottery_app/controllers/firestore_controller.dart';
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

  void addTickets(int n) {
    _tickets += n;
    FirestoreController.updateUser(user);
    notifyListeners();
  }

  void removeTickets(int n) {
    _tickets -= n;
    FirestoreController.updateUser(user);
    notifyListeners();
  }

  Status get status => _status;

  set status(Status status) {
    _status = status;
    notifyListeners();
  }

  String get id => (_user == null) ? "GUEST-" + nanoid(3) : _user!.uid;
  String? get name => _user?.displayName;
  String? get email => _user?.email;
  int? get tickets => (_user == null) ? null : _tickets;
  AppUser get user => AppUser(id: id, name: name, email: email, tickets: tickets);

  _init() async {
    _user = await AuthController.getSignedInUser();
    if (_user != null) {
      _status = Status.AUTHENTICATED;
      AppUser? foundUser = await FirestoreController.getUser(id);
      if (foundUser == null) {
        FirestoreController.setUser(user);
      }
      _tickets = foundUser?.tickets ?? 0;
    }
  }

  Future<bool> signIn() async {
    _status = Status.WAITING;
    notifyListeners();

    _user = await AuthController.signInWithGoogle();

    if (_user != null) {
      _status = Status.AUTHENTICATED;
      AppUser? foundUser = await FirestoreController.getUser(id);
      if (foundUser == null) {
        FirestoreController.setUser(user);
      }
      _tickets = foundUser?.tickets ?? 0;      notifyListeners();
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
    _tickets = 0;
    _status = Status.UNAUTHENTICATED;
    notifyListeners();
  }
}
