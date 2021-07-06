import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottery_app/models/address.dart';
import 'package:lottery_app/models/app_user.dart';

enum Status { Authenticated, Authenticating, Unauthenticated }

class UserStore extends ChangeNotifier {
  AppUser? _appUser = AppUser(name: "AdminUser", address: Address());
  int _tickets = 0; // TODO: Tickets should be some kind of UUID - AssignedUser Map?
  FirebaseAuth _auth;
  GoogleSignIn _signIn = GoogleSignIn();
  User? _gUser;
  Status _status = Status.Unauthenticated;

  UserStore() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(handleAuthChange);
  }

  AppUser? get appUser => _appUser;

  set appUser(AppUser? user) {
    _appUser = user;
    notifyListeners();
  }

  int get tickets {
    if (_status == Status.Authenticated) {
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
    try {
      _status = Status.Authenticating;
      notifyListeners();

      final GoogleSignInAccount? gUser = await _signIn.signIn();
      if (gUser == null) throw Error();
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      await _auth.signInWithCredential(credential);

      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _auth.signOut();
    _signIn.signOut();
    _gUser = null;
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  Future<void> handleAuthChange(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _gUser = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
