class VoiceProfile {
  final String id;
  final String name;
  final String description;
  final bool isFavorite;

  const VoiceProfile({
    required this.id,
    required this.name,
    required this.description,
    this.isFavorite = false,
  });

  factory VoiceProfile.empty() => const VoiceProfile(
        id: 'custom',
        name: 'Custom',
        description: 'User-defined profile',
      );
}
