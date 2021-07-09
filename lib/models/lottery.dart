import 'package:flutter/material.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';
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
  Map<String, int> ticketsMap;
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
    if (ticketsMap.isNotEmpty) {
      return ticketsMap.values.reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": (image == null) ? "no" : "yes",
        "condition": condition.index,
        "category": category.index,
        "shippingCost": shippingCost,
        "endingDate": endingDate,
        "ticketsMap": ticketsMap.keys.toList(),
        "seller": seller.toJson(),
        "winner": winner?.toJson(),
        "collectType": collectType.index,
      };

  Lottery.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        image = null,
        condition = Condition.values[json["condition"]],
        category = Category.values[json["category"]],
        shippingCost = json["shippingCost"],
        endingDate = json["endingDate"].toDate(),
        ticketsMap = {for (String id in json["ticketsMap"]) id: 1},
        seller = AppUser.fromJson(json["seller"]),
        winner = json["winner"] == null ? null : AppUser.fromJson(json["winner"]),
        collectType = CollectType.values[json["collectType"]];
}
