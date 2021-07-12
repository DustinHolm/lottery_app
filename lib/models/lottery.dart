import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:nanoid/nanoid.dart';

class Lottery {
  String id;
  String name;
  String description;
  String? image;
  Condition condition;
  Category category;
  int shippingCost;
  DateTime endingDate;
  Map<String, int> ticketMap;
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
    required this.ticketMap,
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
    required this.ticketMap,
    required this.seller,
    required this.winner,
    required this.collectType,
  }) : id = nanoid();

  int getTicketsUsed() {
    if (ticketMap.isNotEmpty) {
      return ticketMap.values.reduce((a, b) => a + b);
    } else {
      return 0;
    }
  }

  addTicket(String userId) {
    int old = ticketMap[userId] ?? 0;
    ticketMap[userId] = old + 1;
    List<String> allTickets = ticketMap.entries.map((entry) {
      List<String> tickets = [];
      for (int i = 0; i < entry.value; i++) {
        tickets.add(entry.key);
      }
      return tickets;
    }).reduce((a, b) => a + b);
    int randInt = Random().nextInt(allTickets.length);
    winner = AppUser(id: allTickets[randInt]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "condition": condition.index,
        "category": category.index,
        "shippingCost": shippingCost,
        "endingDate": Timestamp.fromDate(endingDate),
        "ticketMap": ticketMap,
        "seller": seller.toJson(),
        "winner": winner?.toJson(),
        "collectType": collectType.index,
      };

  Lottery.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        image = json["image"],
        condition = Condition.values[json["condition"]],
        category = Category.values[json["category"]],
        shippingCost = json["shippingCost"],
        endingDate = json["endingDate"].toDate(),
        ticketMap = Map<String, int>.from(json["ticketMap"]),
        seller = AppUser.fromJson(json["seller"]),
        winner =
            json["winner"] == null ? null : AppUser.fromJson(json["winner"]),
        collectType = CollectType.values[json["collectType"]];

  @override
  bool operator ==(Object other) {
    return (other is Lottery) &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.condition == condition &&
        other.category == category &&
        other.shippingCost == shippingCost &&
        other.endingDate == endingDate &&
        other.seller == seller &&
        other.winner == winner &&
        other.collectType == collectType &&
        const DeepCollectionEquality().equals(ticketMap, other.ticketMap);
  }

  @override
  int get hashCode => hashValues(
        id.hashCode,
        name.hashCode,
        description.hashCode,
        image.hashCode,
        condition.hashCode,
        category.hashCode,
        shippingCost.hashCode,
        endingDate.hashCode,
        seller.hashCode,
        winner.hashCode,
        collectType.hashCode,
        const DeepCollectionEquality().hash(ticketMap),
      );
}
