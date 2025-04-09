import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';


class StatusCard extends StatelessWidget {
  final String donationId;
  final String currentStatus;
  final String itemName;
  final int quantity;
  final String pickupOption;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;
  final bool showFullDetails;
  final VoidCallback onToggleDetails;

  StatusCard({
    required this.donationId,
    required this.currentStatus,
    required this.itemName,
    required this.quantity,
    required this.pickupOption,
    this.pickupDate,
    this.pickupTime,
    required this.showFullDetails,
    required this.onToggleDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Donation ID: $donationId',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(currentStatus),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    currentStatus,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item: $quantity x $itemName',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: onToggleDetails,
                  child: Icon(
                    showFullDetails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 32,
                    color: appBlackColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Pickup Option: $pickupOption',
              style: TextStyle(fontSize: 16),
            ),
            if (pickupOption == 'Schedule Pickup' && pickupDate != null && pickupTime != null) ...[
              SizedBox(height: 8),
              Text(
                'Scheduled For: ${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year} at ${pickupTime!.hour}:${pickupTime!.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Picked Up':
        return Colors.blue;
      case 'Completed':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  StepProgressIndicator({
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(steps.length, (index) {
            final isActive = index <= currentStep;
            final isFirst = index == 0;
            final isLast = index == steps.length - 1;
            
            return Expanded(
              child: Row(
                children: [
                  // Line before circle (except for first item)
                  if (!isFirst)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isActive ? Color(0xFF1565C0) : Colors.grey[300],
                      ),
                    ),
                  
                  // Circle
                  // Container(
                  //   width: 24,
                  //   height: 24,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: isActive ? Color(0xFF1565C0) : Colors.grey[300],
                  //     border: Border.all(
                  //       //color: isActive ? Color(0xFF1565C0) : Colors.grey[300],
                  //       width: 2,
                  //     ),
                  //   ),
                  //   child: isActive
                  //       ? Icon(Icons.check, color: Colors.white, size: 16)
                  //       : null,
                  // ),
                  
                  // Line after circle (except for last item)
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index < currentStep ? Color(0xFF1565C0) : Colors.grey[300],
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) {
            final index = steps.indexOf(step);
            final isActive = index <= currentStep;
            
            return Text(
              step,
              style: TextStyle(
                color: isActive ? Color(0xFF1565C0) : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}