// import 'dart:convert';
// import 'package:flutter_application_1/models/userProfile.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class UserProfileController extends GetxController {
//   var userProfile = UserProfile(firstName: '', lastName: '', email: '', phoneNumber: '').obs;

//   final String updateUrl = "https://sanerylgloann.co.ke/donorApp/updateProf.php?";

//   Future<void> updateUserProfile(UserProfile profile) async {
//     try {
//       final response = await http.post(
//         Uri.parse(updateUrl),
//         body: profile.toJson(),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == 1) {
//           userProfile.value = profile;
//           Get.snackbar("Success", "Profile updated successfully!");
//         } else {
//           Get.snackbar("Error", data['message'] ?? "Failed to update profile.");
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Something went wrong: $e");
//     }
//   }
// }
