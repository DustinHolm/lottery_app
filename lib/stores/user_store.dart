import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:lottery_app/models/address.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/models/user.dart';

class UserStore extends ChangeNotifier {
  User? _user = User(name: "AdminUser", address: Address());
  int _tickets = 0; // TODO: Tickets should be some kind of UUID - AssignedUser Map?

  User? get user => _user;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  int get tickets => _tickets;

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
}