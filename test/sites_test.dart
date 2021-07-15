import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/bidder_page.dart';
import 'package:lottery_app/pages/seller_page.dart';
import 'package:lottery_app/stores/favorites_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

import 'defaults.dart';
import 'mock_favorites_store.dart';
import 'mock_user_store.dart';

void main() {
  group("Sites display correct content tests", () {
    testWidgets('overview test', (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          StreamProvider<List<Lottery>>(
            create: (c) => Stream.fromIterable([Defaults.getLotteries()]),
            initialData: [],
          ),
          ChangeNotifierProvider<UserStore>(
              create: (context) => MockUserStore())
        ],
        child: MaterialApp(home: OverviewPage()),
      ));

      final lotteryFinder = find.text(
          '2Test3'); //sollte so schon gehen wenn der stream funktionieren würde
      expect(lotteryFinder, findsOneWidget);
    });

    testWidgets('bidder page test', (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          StreamProvider<List<Lottery>>(
            create: (c) => Stream.fromIterable([Defaults.getLotteries()]),
            initialData: [],
          ),
          ChangeNotifierProvider<UserStore>(
              create: (context) => MockUserStore()),
          ChangeNotifierProvider<FavoritesStore>(
              create: (context) => MockFavoritesStore())
        ],
        child: MaterialApp(home: BidderPage()),
      ));

      final lotteryFinder = find.text(
          'Platzhalter'); //geht nur wenn tickets in dem 'Platzhalter' von dem Test-User sind
      expect(lotteryFinder,
          findsOneWidget); //alternativ: es dürfte keine ergebnisse geben
    });

    testWidgets('seller page test', (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          StreamProvider<List<Lottery>>(
            create: (c) => Stream.fromIterable([Defaults.getLotteries()]),
            initialData: [],
          ),
          ChangeNotifierProvider<UserStore>(
              create: (context) => MockUserStore())
        ],
        child: MaterialApp(home: SellerPage()),
      ));

      final lotteryFinder = find.text(
          'Platzhalter'); //geht nur wenn der Test-User der Seller ist von 'Platzhalter'
      expect(lotteryFinder,
          findsOneWidget); //alternativ: es dürfte keine ergebnisse geben
    });
  });
}
