import 'package:flutter/material.dart';

class AudioMeter extends StatelessWidget {
  final double value;

  const AudioMeter({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final normalized = value.clamp(0.0, 1.0);
    final color = normalized < 0.35
        ? const Color(0xFFFFB547)
        : normalized < 0.7
            ? const Color(0xFFFF8A4C)
            : const Color(0xFFFF4F4F);

    return Container(
      height: 134,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF242321), Color(0xFF14181B)],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFF725638).withValues(alpha: 0.65)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.28),
            blurRadius: 20,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Input Meter', style: TextStyle(color: Colors.white70, fontSize: 15)),
              Text('${(normalized * 100).toStringAsFixed(0)}%', style: TextStyle(color: color, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF302B24),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FractionallySizedBox(
                  widthFactor: normalized,
                  heightFactor: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF5DE2C8), Color(0xFFFFD166), Color(0xFFFF6B6B)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
