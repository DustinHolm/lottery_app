import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

class Lottery {
  String id;
  String name;
  String description;
  Image? image;
  Condition condition;
  Category category;
  int shippingCost;
  DateTime endingDate;
  Map<AppUser, int> ticketsMap;
  AppUser seller;
  AppUser? winner;
  CollectType collectType;

  Lottery({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.condition,
    required this.category,
    required this.shippingCost,
    required this.endingDate,
    required this.ticketsMap,
    required this.seller,
    required this.winner,
    required this.collectType,
  });

  Lottery.withRandomId({
    required this.name,
    required this.description,
    required this.image,
    required this.condition,
    required this.category,
    required this.shippingCost,
    required this.endingDate,
    required this.ticketsMap,
    required this.seller,
    required this.winner,
    required this.collectType,
  }) : id = nanoid();

  int getTicketsUsed() {
    if (ticketsMap.isNotEmpty)
      return ticketsMap.values.reduce((value, element) => value + element);
    else
      return 0;
  }
}
