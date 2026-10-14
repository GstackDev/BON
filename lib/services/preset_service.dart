import '../models/preset.dart';

class PresetService {
  final List<Preset> presets = [
    const Preset(id: 'bon_style', name: 'Bon Style', values: {'gain': 0.72, 'mix': 0.5}),
    const Preset(id: 'bon_clean', name: 'Bon Clean', values: {'gain': 0.45, 'mix': 0.3}),
    const Preset(id: 'bon_damaged', name: 'Bon Damaged', values: {'gain': 0.88, 'mix': 0.8}),
  ];

  Preset? findById(String id) {
    for (final preset in presets) {
      if (preset.id == id) {
        return preset;
      }
    }
    return null;
  }
}
