class MoneyDonation {
  final String donationsID;
  final String itemsID;
  final String userID;
  final String firstName;
  final String lastName;
  final String timestamp;
  final String amount;

  MoneyDonation({
    required this.donationsID,
    required this.itemsID,
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.timestamp,
    required this.amount,
  });

  factory MoneyDonation.fromJson(Map<String, dynamic> json) {
    return MoneyDonation(
      donationsID: json['donationsID'],
      itemsID: json['itemsID'],
      userID: json['userID'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      timestamp: json['timestamp'],
      amount: json['amount'],
    );
  }
}
