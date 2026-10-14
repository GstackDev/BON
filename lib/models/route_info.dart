class RouteInfo {
  final String id;
  final String label;
  final bool isActive;

  const RouteInfo({
    required this.id,
    required this.label,
    this.isActive = false,
  });
}
