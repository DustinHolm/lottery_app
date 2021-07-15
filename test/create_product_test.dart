
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/components/enum_dropdown_button.dart';
import 'package:lottery_app/components/new_product_page/category_selector.dart';
import 'package:lottery_app/components/new_product_page/description_selection.dart';
import 'package:lottery_app/components/new_product_page/name_selection.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/pages/create_new_product_page.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

void main() {
  Category? testCategory;
  Condition? testCondition;
  CollectType? testCollectType;

  final testController = TextEditingController();

  testWidgets('Create a new product with the CreateProductPage', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<UserStore>(
          create: (context) => MockUserStoreProvider(),
          child: const CreateNewProductPage(),
        ),
      )
    );

    //Testing the Image Selection
    //await tester.tap(find.byType(IconButton));

    //Testing the Enter Name TextField
    await tester.enterText(find.byType(NameSelection), 'Produkt Name');
    await tester.pump();
    expect(find.text('Produkt Name'), findsOneWidget);

    //Testing the Enter Description TextField
    await tester.enterText(find.byType(DescriptionSelection), 'Beschreibung');
    await tester.pump();
    expect(find.text('Beschreibung'), findsOneWidget);

    //Choose a Category from the Dropdown Menu
    var finder = find.byType(CategorySelector);
    tester.tap(finder);
    await tester.pump();

    var category = find.text('Bücher');
    tester.tap(category);
    await tester.pump();

    expect(find.text('Bücher'), findsOneWidget);


    /*tester.any(find.byWidget(CategorySelector(productCategory: Category.BOOKS, handleCategoryUpdate: (Category category) =>
    testCategory = category)));
    await tester.pump();
    expect(testCategory, Category.BOOKS);


    //Choose a Condition from Dropdown Menu
    await tester.any(find.byWidget(ConditionSelector(productCondition: Condition.OK, handleConditionUpdate: (Condition condition) =>
        testCondition = condition)));
    await tester.pump();
    expect(testCondition, Condition.OK);

    tester.any(find.byWidget(ShippingSelector(productCollectType: CollectType.PACKET, handleCollectTypeUpdate: (CollectType type) =>
        testCollectType = type, controller: testShippingCostController,)));
    await tester.pump();
    expect(testCollectType, CollectType.PACKET);
    */







  });
}

class MockUserStoreProvider extends Mock implements UserStore {
  @override
  Status status = Status.AUTHENTICATED;
}
