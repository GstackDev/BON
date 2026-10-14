import 'package:flutter/material.dart';

class ParameterSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;

  const ParameterSlider({
    required this.label,
    required this.value,
    this.min = 0,
    this.max = 100,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          divisions: 100,
          onChanged: onChanged ?? (_) {},
        ),
      ],
    );
  }
}
