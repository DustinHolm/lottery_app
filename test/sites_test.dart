import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/bidder_page.dart';
import 'package:lottery_app/pages/seller_page.dart';
import 'mockstream.dart';


void main(){

  testWidgets('overview test', (WidgetTester tester) async{
    await tester.pumpWidget(StreamProvider(
      builder: (c) => Mockstream,
      child: OverviewPage(),
    ));

    final lotteryFinder = find.text('2Test3');  //sollte so schon gehen wenn der stream funktionieren würde
    expect(lotteryFinder, findsOneWidget);
  });

  testWidgets('bidder page test', (WidgetTester tester) async{
    await tester.pumpWidget(StreamProvider(
      builder: (c) => Mockstream,
      child: BidderPage(),
    ));

    final lotteryFinder = find.text('Platzhalter'); //geht nur wenn tickets in dem 'Platzhalter' von dem Test-User sind
    expect(lotteryFinder, findsOneWidget);          //alternativ: es dürfte keine ergebnisse geben
  });

  testWidgets('seller page test', (WidgetTester tester) async{
    await tester.pumpWidget(StreamProvider(
      builder: (c) => Mockstream,
      child: SellerPage(),
    ));

    final lotteryFinder = find.text('Platzhalter'); //geht nur wenn der Test-User der Seller ist von 'Platzhalter'
    expect(lotteryFinder, findsOneWidget);          //alternativ: es dürfte keine ergebnisse geben
  });


}