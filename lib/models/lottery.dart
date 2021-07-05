import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/product.dart';

class Lottery {
  Product product;
  DateTime startingDate;
  DateTime endingDate;
  Map<AppUser, int> ticketsMap;
  AppUser seller;
  AppUser? winner;
  CollectType collectType;

  Lottery({
    required this.product,
    required this.startingDate,
    required this.endingDate,
    required this.ticketsMap,
    required this.seller,
    required this.winner,
    required this.collectType,
  });

  int getTicketsUsed() {
    if (ticketsMap.isNotEmpty)
      return ticketsMap.values.reduce((value, element) => value + element);
    else
      return 0;
  }
}
