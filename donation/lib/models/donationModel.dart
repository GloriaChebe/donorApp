import 'package:flutter/material.dart';

class Donation {
   String userID;
   String firstName;
   String lastName;
   String category;
   String name;
   String donationId;
   String itemsID;
   String address;
   String deliveryMethod;
   String preferredDate;
   String preferredTime;
  int quantity;
   String status;
  String comments;

  Donation({
    required this.userID,
     required this.firstName,
    required this.lastName,
    required this.category,
    required this.name,
    required this.donationId,
    required this.itemsID,
    required this.address,
    required this.deliveryMethod,
    required this.preferredDate,
    required this.preferredTime,
    required this.quantity,
    required this.status,
    required this.comments,
  });

  // Convert Donation object to JSON for API requests
  Map<String, String> toJson() {
    return {
      'userID': userID,
       'firstName': firstName,
      'lastName': lastName,
      'category': category,
      'name': name,
      'donationId': donationId,
      'itemsID': itemsID,
      'address': address,
      'donationMethod': deliveryMethod,
      'preferredDate': preferredDate,
      'preferredTime': preferredTime,
      'quantity': quantity.toString(),
      'status': status,
      'comments': comments,
    };
  }
}