class Preset {
  final String id;
  final String name;
  final Map<String, num> values;

  const Preset({
    required this.id,
    required this.name,
    required this.values,
  });

  factory Preset.fromJson(Map<String, dynamic> json) {
    return Preset(
      id: json['id'] as String,
      name: json['name'] as String,
      values: Map<String, num>.from(json['values'] as Map? ?? const {}),
    );
  }
}
