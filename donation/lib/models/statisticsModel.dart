class DashboardSummary {
  final int totalDonations;
  final int totalUsers;
  final int pendingApprovals;

  DashboardSummary({
    required this.totalDonations,
    required this.totalUsers,
    required this.pendingApprovals,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalDonations: int.parse(json['total_donations']),
      totalUsers: int.parse(json['total_users']),
      pendingApprovals: int.parse(json['pending_approvals']),
    );
  }
}
