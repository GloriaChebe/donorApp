// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// class AuthController extends GetxController {
//   final storage = GetStorage();

//   Future<bool> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sanerylgloann.co.ke/donorApp/login.php'),
//         body: {
//           'email': email,
//           'password': password,
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         if (jsonData['success'] == 1) {
//           // Store userID in GetStorage
//           storage.write('userID', jsonData['userID']);
//           return true;
//         } else {
//           Get.snackbar('Login Failed', 'Invalid email or password');
//         }
//       } else {
//         Get.snackbar('Error', 'Server returned ${response.statusCode}');
//       }
//     } catch (e) {
//       Get.snackbar('Exception', e.toString());
//     }
//     return false;
//   }

//   String? get userID => storage.read('userID');
// }
