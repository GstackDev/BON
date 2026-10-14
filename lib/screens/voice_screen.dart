import 'package:flutter/material.dart';

import '../widgets/parameter_slider.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  double inputGain = 0.72;
  double mix = 0.62;
  double pitch = 0.25;
  double formant = 0.35;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Voice Engine', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ParameterSlider(label: 'Input gain', value: inputGain, min: 0, max: 1, onChanged: (v) => setState(() => inputGain = v)),
        ParameterSlider(label: 'Voice mix', value: mix, min: 0, max: 1, onChanged: (v) => setState(() => mix = v)),
        ParameterSlider(label: 'Pitch', value: pitch, min: -1, max: 1, onChanged: (v) => setState(() => pitch = v)),
        ParameterSlider(label: 'Formant', value: formant, min: -1, max: 1, onChanged: (v) => setState(() => formant = v)),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current profile', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Bon Style • ${inputGain.toStringAsFixed(2)} gain'),
                const SizedBox(height: 4),
                Text('Mix ${mix.toStringAsFixed(2)} • Pitch ${pitch.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
