import 'package:flutter/material.dart';

class Donation {
  final String itemName;
  final String itemImage;
  final String itemCategory;
  int quantity;
  String pickupOption;
  String? address;
  DateTime? preferredDate;
  TimeOfDay? preferredTime;

  Donation({
    required this.itemName,
    required this.itemImage,
    required this.itemCategory,
    this.quantity = 1,
    this.pickupOption = 'Schedule Pickup',
    this.address,
    this.preferredDate,
    this.preferredTime,
  });
}