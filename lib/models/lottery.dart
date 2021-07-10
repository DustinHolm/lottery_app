import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:nanoid/nanoid.dart';

import 'bid_tickets.dart';

class Lottery {
  String id;
  String name;
  String description;
  Image? image;
  Condition condition;
  Category category;
  int shippingCost;
  DateTime endingDate;
  BidTickets bidTickets;
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
    required this.bidTickets,
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
    required this.bidTickets,
    required this.seller,
    required this.winner,
    required this.collectType,
  }) : id = nanoid();

  int getTicketsUsed() {
    if (bidTickets.ticketMap.isNotEmpty) {
      return bidTickets.ticketMap.values.reduce((a, b) => a + b);
    } else {
      return 0;
    }
  }

  addTicket(String userId) {
    int old = bidTickets.ticketMap[userId] ?? 0;
    bidTickets.ticketMap[userId] = old + 1;
    List<String> allTickets = bidTickets.ticketMap.entries.map((entry) {
      List<String> tickets = [];
      for (int i = 0; i < entry.value; i++) {
        tickets.add(entry.key);
      }
      return tickets;
    }).reduce((a, b) => a + b);
    int randInt = Random().nextInt(allTickets.length);
    bidTickets.nextWinner = allTickets[randInt];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": (image == null) ? "no" : "yes",
        "condition": condition.index,
        "category": category.index,
        "shippingCost": shippingCost,
        "endingDate": Timestamp.fromDate(endingDate),
        "bidTickets": bidTickets.toJson(),
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
        bidTickets = BidTickets.fromJson(json["bidTickets"]),
        seller = AppUser.fromJson(json["seller"]),
        winner = json["winner"] == null ? null : AppUser.fromJson(json["winner"]),
        collectType = CollectType.values[json["collectType"]];
}
