import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/donationModel.dart';
import 'package:get/get.dart';


class DonationController extends GetxController {
  final Donation donation;

  DonationController(this.donation);

  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  void updateQuantity(int value) {
    if (donation.quantity + value > 0) {
      donation.quantity += value;
      update();
    }
  }

  void updatePickupOption(String option) {
    donation.pickupOption = option;
    update();
  }

  void updatePreferredDate(DateTime date) {
    donation.preferredDate = date;
    dateController.text = "${date.day}/${date.month}/${date.year}";
    update();
  }

  void updatePreferredTime(TimeOfDay time) {
    donation.preferredTime = time;
    timeController.text = "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
    update();
  }

  void submitDonation() {
    if (formKey.currentState!.validate()) {
      // Handle donation submission logic
      Get.snackbar('Success', 'Donation submitted successfully!');
    }
  }
}