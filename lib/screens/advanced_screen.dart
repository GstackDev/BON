import 'package:flutter/material.dart';

import '../widgets/parameter_slider.dart';

class AdvancedScreen extends StatefulWidget {
  const AdvancedScreen({super.key});

  @override
  State<AdvancedScreen> createState() => _AdvancedScreenState();
}

class _AdvancedScreenState extends State<AdvancedScreen> {
  double sustain = 0.4;
  double room = 0.55;
  double saturation = 0.76;
  double limiter = 0.88;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced DSP')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ParameterSlider(label: 'Sustain', value: sustain, min: 0, max: 1, onChanged: (v) => setState(() => sustain = v)),
          ParameterSlider(label: 'Room size', value: room, min: 0, max: 1, onChanged: (v) => setState(() => room = v)),
          ParameterSlider(label: 'Saturation', value: saturation, min: 0, max: 1, onChanged: (v) => setState(() => saturation = v)),
          ParameterSlider(label: 'Limiter', value: limiter, min: 0, max: 1, onChanged: (v) => setState(() => limiter = v)),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('DSP Summary', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Sustain ${sustain.toStringAsFixed(2)} • Room ${room.toStringAsFixed(2)}'),
                  Text('Drive ${saturation.toStringAsFixed(2)} • Ceiling ${limiter.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
