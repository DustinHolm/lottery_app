import 'package:flutter/material.dart';
import 'package:lottery_app/enums/condition.dart';

class Product {
  String name;
  String description; // Should be replaced by some kind of Map
  List<Image> images; // Should probably be a List of Links?
  Condition condition;
  int shippingCost;

  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.condition,
    required this.shippingCost
  });
}