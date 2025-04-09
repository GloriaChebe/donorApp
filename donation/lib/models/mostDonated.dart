class TopDonationItem {
  final String name;
  final int numbers;

  TopDonationItem({required this.name, required this.numbers});

  factory TopDonationItem.fromJson(Map<String, dynamic> json) {
    return TopDonationItem(
      name: json['name'],
      numbers: int.parse(json['numbers']),
    );
  }
}
