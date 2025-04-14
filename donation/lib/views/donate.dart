import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/configs/constants.dart' as color;
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/views/status.dart';

import 'package:get/get.dart';

import 'dart:math' as math;

import 'package:get/get_connect/http/src/response/response.dart' as get_response;
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

var storage = GetStorage();
class DonatePage extends StatefulWidget {
  final String itemName;
  final String itemImage; 
  final String itemCategory;
   String itemsID;

  DonatePage({
    required this.itemName, 
    this.itemImage = '', 
    this.itemCategory = 'General',
    required this.itemsID , 
    
  });

  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final _formKey = GlobalKey<FormState>();
  int _quantity = 1;
  String _pickupOption = 'Schedule Pickup'; // Match the radio button value
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _additionalNotesController = TextEditingController();
  
  String? _donationId;
  
  get donationData => null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = color.primaryColor; // Deep blue color

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,foregroundColor: appwhiteColor,
        elevation: 0,
        title: Text(
          'Donate ${widget.itemName}',
          style: TextStyle(fontWeight: FontWeight.bold,color: appwhiteColor),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showDonationInfo(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item info card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: primaryColor.withOpacity(0.1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: 
                    widget.itemImage.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://sanerylgloann.co.ke/donorApp/itemImages/${widget.itemImage}',
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.inventory_2_outlined,
                            size: 50,
                            color: Colors.grey.shade400,
                          ),
                  ),
                  SizedBox(width: 16),
                  // Item details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.itemName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Category: ${widget.itemCategory}',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 16),
                        // Quantity selector
                        Row(
                          children: [
                            Text(
                              'Quantity:',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: _quantity > 1
                                        ? () => setState(() => _quantity--)
                                        : null,
                                    constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                                    padding: EdgeInsets.zero,
                                    iconSize: 18,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      '$_quantity',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () => setState(() => _quantity++),
                                    constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                                    padding: EdgeInsets.zero,
                                    iconSize: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Donation form
            Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
               
                    SizedBox(height: 24),

                    // Pickup/Dropoff section
                    Text(
                      'Donation Method',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Pickup options
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: Text('Schedule a Pickup'),
                            subtitle: Text('We\'ll come to your address'),
                            value: 'Schedule Pickup',
                            groupValue: _pickupOption,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                _pickupOption = value!;
                                print(_pickupOption);
                              });
                            },
                          ),
                          Divider(height: 1),
                          RadioListTile<String>(
                            title: Text('Drop Off at Center'),
                            subtitle: Text('Bring items to our donation center'),
                            value: 'Drop Off',
                            groupValue: _pickupOption,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                _pickupOption = value!;
                                print(_pickupOption);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),

                    // Address field
                    if (_pickupOption == 'Schedule Pickup') ...[
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.home_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (_pickupOption == 'Schedule Pickup' && (value == null || value.isEmpty)) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Date and time pickers
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _dateController,
                          
                              decoration: InputDecoration(
                                labelText: 'Preferred Date',
                                prefixIcon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now().add(Duration(days: 1)),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(Duration(days: 30)),
                                );
                                if (picked != null) {
                                  setState(() {
                                   
                                    _selectedDate = picked;
                                    _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                                     print('_selectedDate');
                                  });
                                }
                              },
                              validator: (value) {
                                if (_pickupOption == 'Schedule Pickup' && (value == null || value.isEmpty)) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _timeController,
                              decoration: InputDecoration(
                                labelText: 'Preferred Time',
                                prefixIcon: Icon(Icons.access_time),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _selectedTime = picked;
                                    _timeController.text = "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
                                    print(_selectedTime);
                                  });
                                }
                              },
                              validator: (value) {
                                if (_pickupOption == 'Schedule Pickup' && (value == null || value.isEmpty)) {
                                  return 'Please select a time';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else if (_pickupOption == 'Drop Off') ...[
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Donation Center',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, color: primaryColor),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '123 popo road, South C, Nairobi',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.access_time, color: primaryColor),
                                SizedBox(width: 8),
                                Text(
                                  'Open: Mon-Fri 9AM-5PM, Sat 10AM-2PM',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 16),

                    // Additional notes
                   TextFormField(
                         controller: _additionalNotesController, // Attach the controller
                           decoration: InputDecoration(
                           labelText: 'Additional Notes (Optional)',
                             border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8),
                                 ),
                                 contentPadding: EdgeInsets.all(16),
                                    ),
                                       maxLines: 3,
                                         ),
                    SizedBox(height: 24),

                    // Submit button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            http.Response response = await http.post(
                              Uri.parse('https://sanerylgloann.co.ke/donorApp/createDonations.php'),
                              body: {
                                'userID': storage.read("userID") ?? '',
                                'itemsID': widget.itemsID,
                                'address': _pickupOption == 'Schedule Pickup' ? _addressController.text : '',
                                'deliveryMethod': _pickupOption,
                                'prefferedDate': _selectedDate != null
                                    ? "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}"
                                    : '',
                                'prefferedTime': _selectedTime != null
                                    ? "${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}"
                                    : '',
                                'quantity': _quantity.toString(),
                                'status': 'Pending',
                                'comments': _additionalNotesController.text,
                              },
                            );

                            print('Response: ${response.body}');
                            if (response.statusCode == 200) {
                              var res = jsonDecode(response.body);
                              print('Response: $res');

                              if (res['success'] == 1) {
                                // Show the Thank You dialog
                                _showThankYouDialog(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error Occurred')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed')),
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Complete Donation',
                            style: TextStyle(
                              color: appwhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // Terms text
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Show terms
                        },
                        child: Text(
                          'By donating, you agree to our Terms & Conditions',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitDonation() {
    _donationId = 'DON${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    _showSubmissionConfirmation();
  }

  void _showSubmissionConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your donation request has been submitted!',),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green.shade700,
                  size: 48,
                ),
              ),
              SizedBox(height: 16),
             
              Text(
                'Donation ID: $_donationId',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),
              Text(
                'Your donation is pending approval from our administrators. You can check the status of your donation on the app at any time.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              SizedBox(height: 16),
              
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('View Status',style: TextStyle(color: appwhiteColor),),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToDonationStatus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDonationStatus() {
    Get.to(() => Statuspage(
      donationId: '0',
      itemName: widget.itemName,
      quantity: _quantity,
      pickupOption: _pickupOption, currentStatus: '',
    ));
    
  }

  void _showDonationInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF1565C0)),
              SizedBox(width: 8),
              Text('About Donations'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your donations make a difference!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'All donated items should be in good, usable condition. Your donations help support continuing research projects and contribute to our sustainability efforts.',
                ),
                SizedBox(height: 16),
                
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green.shade700,
                  size: 48,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your donation of $_quantity ${widget.itemName}(s) has been confirmed!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              if (_pickupOption == 'Schedule Pickup')
                Text(
                  'We will pick up your items on ${_dateController.text} at ${_timeController.text}.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700),
                )
              else
                Text(
                  'Please bring your items to our donation center during opening hours.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              SizedBox(height: 16),
              // Text(
              //   'A confirmation email has been sent to your email address.',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              // ),
            ],
          ),
          actions: [
            // TextButton(
            //   child: Text('Share'),
            //   onPressed: () {
            //     // Handle sharing
            //   },
            // ),
            ElevatedButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Return to previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1565C0),
              ),
            ),
          ],
        );
      },
    );
  }
}