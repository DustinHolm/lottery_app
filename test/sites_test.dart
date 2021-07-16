import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/create_new_product_page.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/bidder_page.dart';
import 'package:lottery_app/pages/seller_page.dart';
import 'package:lottery_app/pages/tickets_buy_page.dart';
import 'package:lottery_app/stores/favorites_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

import 'defaults.dart';
import 'mock_favorites_store.dart';
import 'mock_user_store.dart';

void main() {
  group("Sites can be correctly navigated", () {
    testWidgets('Navigation test', (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          StreamProvider<List<Lottery>>(
            create: (c) => Stream.fromIterable([Defaults.getLotteries()]),
            initialData: const [],
          ),
          ChangeNotifierProvider<UserStore>(
              create: (context) => MockUserStore()),
          ChangeNotifierProvider<FavoritesStore>(
              create: (context) => MockFavoritesStore())
        ],
        child: MaterialApp(routes: {
          '/': (context) => const OverviewPage(),
          '/overview': (context) => const OverviewPage(),
          '/bidder': (context) => const BidderPage(),
          '/seller': (context) => const SellerPage(),
          '/create': (context) => const CreateNewProductPage(),
          '/tickets': (context) => const TicketsBuyPage(),
        }),
      ));

      // Standard route leads to OverviewPage
      expect(find.text('Übersicht'), findsOneWidget);
      expect(find.text('Lotteriespiel-App'), findsNothing);

      // Open Sidebar
      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
      await tester.pump();

      // Sidebar open
      expect(find.text('Lotteriespiel-App'), findsOneWidget);
      expect(find.text('Übersicht'), findsNWidgets(2));
      expect(find.text('Offene Gebote'), findsOneWidget);
      expect(find.text('Eigene Angebote'), findsOneWidget);
      expect(find.text('Angebot erstellen'), findsOneWidget);
      expect(find.text('Tickets kaufen'), findsOneWidget);

      // Presses target to navigate
      await tester.tap(find.text('Offene Gebote'));
      await tester.pumpAndSettle();

      // Navigation complete, sidebar closed again
      expect(find.text('Lotteriespiel-App'), findsNothing);
      expect(find.text('Offene Gebote'), findsOneWidget);

      // Open Sidebar
      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
      await tester.pump();

      // Sidebar open
      expect(find.text('Lotteriespiel-App'), findsOneWidget);
      expect(find.text('Übersicht'), findsOneWidget);
      expect(find.text('Offene Gebote'), findsNWidgets(2));
      expect(find.text('Eigene Angebote'), findsOneWidget);
      expect(find.text('Angebot erstellen'), findsOneWidget);
      expect(find.text('Tickets kaufen'), findsOneWidget);

      // Presses target to navigate
      await tester.tap(find.text('Eigene Angebote'));
      await tester.pumpAndSettle();

      // Navigation complete, sidebar closed again
      expect(find.text('Lotteriespiel-App'), findsNothing);
      expect(find.text('Eigene Angebote'), findsOneWidget);

      // Open Sidebar
      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
      await tester.pump();

      // Sidebar open
      expect(find.text('Lotteriespiel-App'), findsOneWidget);
      expect(find.text('Übersicht'), findsOneWidget);
      expect(find.text('Offene Gebote'), findsOneWidget);
      expect(find.text('Eigene Angebote'), findsNWidgets(2));
      expect(find.text('Angebot erstellen'), findsOneWidget);
      expect(find.text('Tickets kaufen'), findsOneWidget);

      // Presses target to navigate
      await tester.tap(find.text('Angebot erstellen'));
      await tester.pumpAndSettle();

      // Navigation complete, sidebar closed again
      expect(find.text('Lotteriespiel-App'), findsNothing);
      expect(find.text('Angebot erstellen'), findsOneWidget);

      // Open Sidebar
      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
      await tester.pump();

      // Sidebar open
      expect(find.text('Lotteriespiel-App'), findsOneWidget);
      expect(find.text('Übersicht'), findsOneWidget);
      expect(find.text('Offene Gebote'), findsOneWidget);
      expect(find.text('Eigene Angebote'), findsOneWidget);
      expect(find.text('Angebot erstellen'), findsNWidgets(2));
      expect(find.text('Tickets kaufen'), findsOneWidget);

      // Presses target to navigate
      await tester.tap(find.text('Tickets kaufen'));
      await tester.pumpAndSettle();

      // Navigation complete, sidebar closed again
      expect(find.text('Lotteriespiel-App'), findsNothing);
      expect(find.text('Tickets kaufen'), findsOneWidget);

      // Open Sidebar
      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
      await tester.pump();

      // Sidebar open
      expect(find.text('Lotteriespiel-App'), findsOneWidget);
      expect(find.text('Übersicht'), findsOneWidget);
      expect(find.text('Offene Gebote'), findsOneWidget);
      expect(find.text('Eigene Angebote'), findsOneWidget);
      expect(find.text('Angebot erstellen'), findsOneWidget);
      expect(find.text('Tickets kaufen'), findsNWidgets(2));
    });
  });
}
